import os
from pydantic_settings import BaseSettings
from functools import lru_cache


class Settings(BaseSettings):
    database_url: str
    redis_url: str
    jwt_secret_key: str
    jwt_algorithm: str = "HS256"
    access_token_expire_minutes: int = 60
    refresh_token_expire_days: int = 7
    groq_api_key: str
    app_env: str = "development"
    app_url: str = "http://localhost:8001"

    class Config:
        env_file = os.path.join(
            os.path.dirname(os.path.dirname(os.path.dirname(__file__))),
            ".env"
        )


@lru_cache
def get_settings() -> Settings:
    return Settings()