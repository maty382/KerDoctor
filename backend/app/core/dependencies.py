from fastapi import Depends, HTTPException, status
from fastapi.security import HTTPBearer, HTTPAuthorizationCredentials
from sqlalchemy.ext.asyncio import AsyncSession
from app.core.security import decode_token
from app.db.base import get_session
from app.models.user import User
from sqlalchemy import select

# HTTPBearer lit automatiquement le header "Authorization: Bearer <token>"
bearer = HTTPBearer()


async def get_current_user(
    credentials: HTTPAuthorizationCredentials = Depends(bearer),
    session: AsyncSession = Depends(get_session),
) -> User:
    """
    Dépendance principale d'authentification.
    À mettre sur n'importe quel endpoint qui nécessite d'être connecté.

    Ce qu'elle fait :
    1. Lit le token JWT dans le header Authorization
    2. Vérifie que le token est valide et non expiré
    3. Récupère l'utilisateur correspondant dans la base de données
    4. Retourne l'utilisateur — sinon lève une erreur 401
    """
    token = credentials.credentials

    # Décode le token
    payload = decode_token(token)

    # Vérifie que le token est valide ET que c'est bien un access token
    if not payload or payload.get("type") != "access":
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Token invalide ou expiré",
        )

    # Récupère l'utilisateur depuis la base de données
    user_id = payload.get("sub")
    result = await session.execute(select(User).where(User.id == user_id))
    user = result.scalar_one_or_none()

    if not user:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Utilisateur introuvable"
        )

    return user


def require_role(*roles: str):
    """
    Factory de garde de rôle.
    Crée une dépendance qui vérifie que l'utilisateur a le bon rôle.

    Utilisation dans un router :
        @router.get("/admin/stats")
        async def stats(user = Depends(require_admin)):
            ...
    """
    async def guard(current_user: User = Depends(get_current_user)) -> User:
        if current_user.role not in roles:
            raise HTTPException(
                status_code=status.HTTP_403_FORBIDDEN,
                detail=f"Accès refusé. Rôle requis : {roles}",
            )
        return current_user
    return guard


# Gardes prêtes à l'emploi — importe et utilise directement dans tes routers
require_patient         = require_role("patient")
require_doctor          = require_role("doctor")
require_admin           = require_role("admin")
require_doctor_or_admin = require_role("doctor", "admin")