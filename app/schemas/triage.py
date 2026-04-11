from pydantic import BaseModel, field_validator
from typing import Optional
from datetime import datetime


class TriageResponse(BaseModel):
    """
    Réponse retournée à Flutter après analyse vocale.
    C'est exactement ce que Maty reçoit et affiche sur l'écran de triage.
    """
    id: str
    urgency_level: int        # 1=critique, 2=consultation, 3=conseils
    summary: str              # Résumé des symptômes en langue choisie
    advice: str               # Conseils immédiats en langue choisie
    transcript: str           # Texte transcrit de l'audio
    language: str             # Langue utilisée
    created_at: datetime

    @field_validator("id", mode="before")
    @classmethod
    def convert_uuid(cls, v):
        return str(v)

    class Config:
        from_attributes = True


class TriageHistoryResponse(BaseModel):
    """
    Réponse pour l'historique des triages d'un patient.
    Retourne les 10 derniers triages.
    """
    triages: list[TriageResponse]
    total: int