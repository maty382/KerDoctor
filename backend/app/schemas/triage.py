from pydantic import BaseModel, field_validator
from datetime import datetime


class TriageResponse(BaseModel):
    id: str
    urgency_level: int
    summary: str
    advice: str
    transcript: str
    language: str
    created_at: datetime

    @field_validator("id", mode="before")
    @classmethod
    def convert_uuid(cls, v):
        return str(v)

    class Config:
        from_attributes = True


class TriageHistoryResponse(BaseModel):
    triages: list[TriageResponse]
    total: int