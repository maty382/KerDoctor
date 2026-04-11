from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from app.routers import auth, triage
from app.core.config import get_settings

settings = get_settings()

# Création de l'application FastAPI
app = FastAPI(
    title="KërDoctor API",
    version="1.0.0",
    docs_url="/docs" if settings.app_env == "development" else None,
    redoc_url="/redoc" if settings.app_env == "development" else None,
)

# CORS — autorise Flutter et le dashboard web à appeler l'API
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Enregistrement des routers
app.include_router(auth.router, prefix="/api/v1")
app.include_router(triage.router, prefix="/api/v1")


@app.get("/health")
async def health():
    """
    Endpoint de vérification — Railway l'utilise pour savoir si l'app tourne.
    """
    return {"status": "ok", "env": settings.app_env}