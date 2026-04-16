from fastapi import APIRouter, Depends, UploadFile, File, Form
from sqlalchemy.ext.asyncio import AsyncSession

from app.db.base import get_session
from app.schemas.triage import TriageResponse, TriageHistoryResponse
from app.services.triage_service import process_voice_triage, get_triage_history
from app.core.dependencies import get_current_user, require_patient
from app.models.user import User

router = APIRouter(prefix="/triage", tags=["triage"])


@router.post("/voice", response_model=TriageResponse, status_code=201)
async def voice_triage(
    # Fichier audio envoyé par Flutter — multipart/form-data
    audio_file: UploadFile = File(..., description="Fichier audio WAV/MP3 max 5MB"),
    # Langue du patient : fr | wo | pu
    language: str = Form(default="fr"),
    # Utilisateur connecté — extrait automatiquement du token JWT
    current_user: User = Depends(require_patient),
    session: AsyncSession = Depends(get_session),
):
    """
    Endpoint principal du triage vocal.
    Reçoit un fichier audio, transcrit, analyse, et retourne le résultat IA.
    Accessible uniquement aux patients connectés.
    """
    # Vérifie la taille du fichier (max 5MB)
    if audio_file.size and audio_file.size > 5 * 1024 * 1024:
        from fastapi import HTTPException
        raise HTTPException(status_code=400, detail="Fichier trop lourd — maximum 5MB")

    return await process_voice_triage(audio_file, language, current_user, session)


@router.get("/history", response_model=TriageHistoryResponse)
async def triage_history(
    current_user: User = Depends(get_current_user),
    session: AsyncSession = Depends(get_session),
):
    """
    Retourne les 10 derniers triages du patient connecté.
    """
    return await get_triage_history(current_user, session)