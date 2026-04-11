from fastapi import APIRouter, Depends
from sqlalchemy.ext.asyncio import AsyncSession

from app.db.base import get_session
from app.schemas.auth import (
    RegisterRequest, LoginRequest, RefreshRequest,
    TokenResponse, UserResponse
)
from app.services.auth_service import (
    register_user, login_user, refresh_tokens, logout_user
)
from app.core.dependencies import get_current_user
from app.models.user import User

# Préfixe /auth — tous les endpoints commencent par /api/v1/auth/
router = APIRouter(prefix="/auth", tags=["auth"])


@router.post("/register", response_model=TokenResponse, status_code=201)
async def register(data: RegisterRequest, session: AsyncSession = Depends(get_session)):
    """
    Inscription d'un nouveau patient ou médecin.
    Retourne directement les tokens pour connecter l'utilisateur sans étape supplémentaire.
    """
    return await register_user(data, session)


@router.post("/login", response_model=TokenResponse)
async def login(data: LoginRequest, session: AsyncSession = Depends(get_session)):
    """
    Connexion avec téléphone + mot de passe.
    Retourne une paire de tokens JWT.
    """
    return await login_user(data, session)


@router.post("/refresh", response_model=TokenResponse)
async def refresh(data: RefreshRequest, session: AsyncSession = Depends(get_session)):
    """
    Renouvelle les tokens quand l'access token expire.
    Flutter appelle cet endpoint automatiquement en arrière-plan.
    """
    return await refresh_tokens(data.refresh_token, session)


@router.post("/logout", status_code=204)
async def logout(data: RefreshRequest, session: AsyncSession = Depends(get_session)):
    """
    Déconnexion — révoque le refresh token.
    Status 204 = succès sans contenu à retourner.
    """
    await logout_user(data.refresh_token, session)


@router.get("/me", response_model=UserResponse)
async def me(current_user: User = Depends(get_current_user)):
    """
    Retourne le profil de l'utilisateur actuellement connecté.
    Nécessite un token valide dans le header Authorization.
    """
    return current_user