from pydantic_settings import BaseSettings
from functools import lru_cache


class Settings(BaseSettings):
    """
    Classe qui lit automatiquement toutes les variables
    depuis le fichier .env et les valide avec Pydantic.
    Si une variable obligatoire manque, l'app plante au démarrage
    avec un message clair — c'est voulu.
    """

    # --- Base de données ---
    database_url: str  # URL PostgreSQL complète

    # --- Redis ---
    redis_url: str  # URL Redis pour le cache

    # --- JWT ---
    jwt_secret_key: str        # Clé secrète pour signer les tokens
    jwt_algorithm: str = "HS256"  # Algorithme de signature (HS256 = standard)
    access_token_expire_minutes: int = 60   # Token accès expire après 1h
    refresh_token_expire_days: int = 7      # Token refresh expire après 7 jours

    # --- Groq (LLM gratuit pour le triage IA) ---
    groq_api_key: str  # Clé API Groq — gratuit sur console.groq.com

    # --- App ---
    app_env: str = "development"
    app_url: str = "http://localhost:8000"

    class Config:
        # Indique à Pydantic de lire le fichier .env automatiquement
        env_file = ".env"


@lru_cache
def get_settings() -> Settings:
    """
    Retourne les settings en cache.
    lru_cache fait que le fichier .env est lu une seule fois
    au démarrage — pas à chaque requête.
    """
    return Settings()