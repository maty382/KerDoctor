from datetime import datetime, timedelta, timezone
from typing import Optional
from jose import JWTError, jwt
from passlib.context import CryptContext
from backend.app.core.config import get_settings

settings = get_settings()

# Contexte de hashage — on utilise bcrypt
# bcrypt est l'algorithme le plus sûr pour les mots de passe
# Il est lent volontairement pour résister aux attaques par force brute
pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")


def hash_password(plain: str) -> str:
    """
    Transforme un mot de passe en clair en hash bcrypt.
    Ex : "monmdp123" → "$2b$12$eImiTXuWVxfM37uY4JANjQ..."
    Ce hash est irréversible — même nous on ne peut pas retrouver le vrai mdp.
    """
    return pwd_context.hash(plain)


def verify_password(plain: str, hashed: str) -> bool:
    """
    Vérifie si un mot de passe en clair correspond à son hash.
    Utilisé lors de la connexion.
    Retourne True si ça correspond, False sinon.
    """
    return pwd_context.verify(plain, hashed)


def create_access_token(user_id: str, role: str) -> str:
    """
    Crée un token JWT d'accès de courte durée (1 heure).
    Ce token est envoyé dans chaque requête API pour identifier l'utilisateur.
    Contient : l'ID utilisateur, son rôle, et la date d'expiration.
    """
    expire = datetime.now(timezone.utc) + timedelta(
        minutes=settings.access_token_expire_minutes
    )
    payload = {
        "sub": user_id,    # "sub" = subject = identifiant de l'utilisateur
        "role": role,       # patient | doctor | admin
        "exp": expire,      # date d'expiration
        "type": "access"    # pour distinguer access token et refresh token
    }
    return jwt.encode(payload, settings.jwt_secret_key, algorithm=settings.jwt_algorithm)


def create_refresh_token(user_id: str) -> str:
    """
    Crée un token JWT de rafraîchissement de longue durée (7 jours).
    Ce token sert uniquement à obtenir un nouvel access token
    quand l'ancien expire — il ne donne pas accès aux endpoints.
    """
    expire = datetime.now(timezone.utc) + timedelta(
        days=settings.refresh_token_expire_days
    )
    payload = {
        "sub": user_id,
        "exp": expire,
        "type": "refresh"   # important : type différent de l'access token
    }
    return jwt.encode(payload, settings.jwt_secret_key, algorithm=settings.jwt_algorithm)


def decode_token(token: str) -> Optional[dict]:
    """
    Décode et vérifie un token JWT.
    Retourne le contenu du token si valide.
    Retourne None si le token est invalide ou expiré.
    """
    try:
        return jwt.decode(
            token,
            settings.jwt_secret_key,
            algorithms=[settings.jwt_algorithm]
        )
    except JWTError:
        # Token invalide, mal formé, ou expiré
        return None