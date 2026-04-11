from sqlalchemy.ext.asyncio import create_async_engine, async_sessionmaker, AsyncSession
from sqlalchemy.orm import DeclarativeBase
from app.core.config import get_settings
from typing import AsyncGenerator

settings = get_settings()

# Crée le moteur de connexion asynchrone à PostgreSQL
# pool_size=10 : jusqu'à 10 connexions simultanées à la DB
# max_overflow=20 : jusqu'à 20 connexions supplémentaires en cas de pic
engine = create_async_engine(
    settings.database_url,
    echo=settings.app_env == "development",  # affiche les requêtes SQL en dev
    pool_size=10,
    max_overflow=20,
)

# Fabrique de sessions — une session = une transaction avec la base de données
AsyncSessionLocal = async_sessionmaker(engine, expire_on_commit=False)


class Base(DeclarativeBase):
    """
    Classe de base pour tous tes modèles SQLAlchemy.
    Chaque modèle (User, Doctor, etc.) hérite de cette classe.
    """
    pass


async def get_session() -> AsyncGenerator[AsyncSession, None]:
    """
    Générateur de session de base de données.
    Utilisé comme dépendance FastAPI dans tous les endpoints qui touchent la DB.

    Ce qu'il fait :
    - Ouvre une session
    - La donne à l'endpoint
    - Commit automatiquement si tout s'est bien passé
    - Rollback automatiquement si une erreur survient
    - Ferme la session dans tous les cas
    """
    async with AsyncSessionLocal() as session:
        try:
            yield session           # donne la session à l'endpoint
            await session.commit()  # valide les changements si pas d'erreur
        except Exception:
            await session.rollback() # annule tout si erreur
            raise