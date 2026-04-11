import hashlib
from datetime import datetime, timedelta, timezone
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select
from fastapi import HTTPException

from backend.app.models.user import User, Doctor, RefreshToken
from backend.app.schemas.auth import RegisterRequest, LoginRequest, TokenResponse
from backend.app.core.security import (
    hash_password, verify_password,
    create_access_token, create_refresh_token, decode_token
)
from backend.app.core.config import get_settings

settings = get_settings()


def _hash_token(token: str) -> str:
    """
    Hash un token JWT avec SHA256 avant de le stocker en base.
    On ne stocke jamais le token brut — si la DB est compromise
    les tokens sont inutilisables sans la clé secrète JWT.
    """
    return hashlib.sha256(token.encode()).hexdigest()


async def register_user(data: RegisterRequest, session: AsyncSession) -> TokenResponse:
    """
    Inscrit un nouvel utilisateur.
    Étapes :
    1. Vérifie que le téléphone n'est pas déjà utilisé
    2. Vérifie les champs médecin si role == doctor
    3. Crée l'utilisateur en base
    4. Crée le profil médecin si nécessaire
    5. Génère et retourne les tokens JWT
    """

    # Étape 1 : téléphone déjà enregistré ?
    existing = await session.execute(
        select(User).where(User.phone == data.phone)
    )
    if existing.scalar_one_or_none():
        raise HTTPException(status_code=400, detail="Ce numéro est déjà enregistré")

    # Étape 2 : champs médecin obligatoires
    if data.role == "doctor":
        if not data.specialty or not data.cnom_number:
            raise HTTPException(
                status_code=400,
                detail="La spécialité et le numéro CNOM sont obligatoires pour les médecins"
            )

    # Étape 3 : création de l'utilisateur
    user = User(
        phone=data.phone,
        full_name=data.full_name,
        role=data.role,
        language=data.language,
        password_hash=hash_password(data.password),
    )
    session.add(user)
    await session.flush()  # flush pour obtenir user.id avant d'insérer le médecin

    # Étape 4 : création du profil médecin si nécessaire
    if data.role == "doctor":
        doctor = Doctor(
            user_id=user.id,
            specialty=data.specialty,
            cnom_number=data.cnom_number,
            languages=data.languages or ["fr"],
        )
        session.add(doctor)

    # Étape 5 : génération des tokens
    access_token  = create_access_token(str(user.id), user.role)
    refresh_token = create_refresh_token(str(user.id))

    # Stocke le hash du refresh token en base
    rt = RefreshToken(
        user_id=user.id,
        token_hash=_hash_token(refresh_token),
        expires_at=datetime.now(timezone.utc) + timedelta(days=settings.refresh_token_expire_days),
    )
    session.add(rt)

    return TokenResponse(
        access_token=access_token,
        refresh_token=refresh_token,
        user_id=str(user.id),
        role=user.role,
        full_name=user.full_name,
    )


async def login_user(data: LoginRequest, session: AsyncSession) -> TokenResponse:
    """
    Connecte un utilisateur existant.
    Étapes :
    1. Cherche l'utilisateur par téléphone
    2. Vérifie le mot de passe
    3. Génère et retourne de nouveaux tokens
    """

    # Étape 1 : cherche l'utilisateur
    result = await session.execute(
        select(User).where(User.phone == data.phone)
    )
    user = result.scalar_one_or_none()

    # Étape 2 : vérifie mdp — message volontairement vague pour la sécurité
    # (on ne dit pas si c'est le téléphone ou le mdp qui est faux)
    if not user or not verify_password(data.password, user.password_hash or ""):
        raise HTTPException(status_code=401, detail="Téléphone ou mot de passe incorrect")

    # Étape 3 : génère les tokens
    access_token  = create_access_token(str(user.id), user.role)
    refresh_token = create_refresh_token(str(user.id))

    rt = RefreshToken(
        user_id=user.id,
        token_hash=_hash_token(refresh_token),
        expires_at=datetime.now(timezone.utc) + timedelta(days=settings.refresh_token_expire_days),
    )
    session.add(rt)

    return TokenResponse(
        access_token=access_token,
        refresh_token=refresh_token,
        user_id=str(user.id),
        role=user.role,
        full_name=user.full_name,
    )


async def refresh_tokens(refresh_token: str, session: AsyncSession) -> TokenResponse:
    """
    Renouvelle une paire de tokens.
    Appelé quand l'access token expire (après 1h).
    Utilise la rotation : l'ancien refresh token est révoqué, un nouveau est créé.
    Cela limite les risques si un token est volé.
    """

    # Décode le refresh token
    payload = decode_token(refresh_token)
    if not payload or payload.get("type") != "refresh":
        raise HTTPException(status_code=401, detail="Refresh token invalide")

    # Cherche le token en base via son hash
    token_hash = _hash_token(refresh_token)
    result = await session.execute(
        select(RefreshToken).where(
            RefreshToken.token_hash == token_hash,
            RefreshToken.is_revoked == False,
        )
    )
    stored = result.scalar_one_or_none()

    # Vérifie que le token existe, n'est pas révoqué, et n'est pas expiré
    if not stored or stored.expires_at < datetime.now(timezone.utc):
        raise HTTPException(status_code=401, detail="Refresh token expiré ou révoqué")

    # Révoque l'ancien token (rotation)
    stored.is_revoked = True

    # Récupère l'utilisateur
    user_result = await session.execute(select(User).where(User.id == stored.user_id))
    user = user_result.scalar_one()

    # Génère une nouvelle paire de tokens
    new_access  = create_access_token(str(user.id), user.role)
    new_refresh = create_refresh_token(str(user.id))

    new_rt = RefreshToken(
        user_id=user.id,
        token_hash=_hash_token(new_refresh),
        expires_at=datetime.now(timezone.utc) + timedelta(days=settings.refresh_token_expire_days),
    )
    session.add(new_rt)

    return TokenResponse(
        access_token=new_access,
        refresh_token=new_refresh,
        user_id=str(user.id),
        role=user.role,
        full_name=user.full_name,
    )


async def logout_user(refresh_token: str, session: AsyncSession) -> None:
    """
    Déconnecte l'utilisateur en révoquant son refresh token.
    L'access token reste valide jusqu'à son expiration (1h max)
    mais sans refresh token l'utilisateur devra se reconnecter.
    """
    token_hash = _hash_token(refresh_token)
    result = await session.execute(
        select(RefreshToken).where(RefreshToken.token_hash == token_hash)
    )
    stored = result.scalar_one_or_none()
    if stored:
        stored.is_revoked = True