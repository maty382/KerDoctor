import uuid
from datetime import datetime, timezone
from sqlalchemy import String, Integer, DateTime, ForeignKey, Text
from sqlalchemy.dialects.postgresql import UUID
from sqlalchemy.orm import Mapped, mapped_column, relationship
from BACKEND.app.db.base import Base
from BACKEND.app.models.user import User

class Triage(Base):
    """
    Table 'triages' — stocke chaque analyse vocale d'un patient.
    C'est le résultat de Whisper + Groq pour une session donnée.
    """
    __tablename__ = "triages"

    # Identifiant unique
    id: Mapped[uuid.UUID] = mapped_column(
        UUID(as_uuid=True), primary_key=True, default=uuid.uuid4
    )

    # Patient qui a enregistré le message vocal
    user_id: Mapped[uuid.UUID] = mapped_column(
        UUID(as_uuid=True),
        ForeignKey("users.id", ondelete="CASCADE"),
        nullable=False
    )

    # URL du fichier audio stocké (sur le serveur ou cloud)
    audio_url: Mapped[str] = mapped_column(String(500), nullable=True)

    # Texte transcrit par Faster-Whisper
    transcript: Mapped[str] = mapped_column(Text, nullable=True)

    # Niveau d'urgence retourné par Groq : 1=critique, 2=consultation, 3=conseils
    urgency_level: Mapped[int] = mapped_column(Integer, nullable=False, default=3)

    # Résumé des symptômes généré par Groq
    summary: Mapped[str] = mapped_column(Text, nullable=True)

    # Conseils immédiats générés par Groq
    advice: Mapped[str] = mapped_column(Text, nullable=True)

    # Langue détectée ou choisie par le patient : fr | wo | pu
    language: Mapped[str] = mapped_column(String(5), default="fr")

    # Date de création
    created_at: Mapped[datetime] = mapped_column(
        DateTime(timezone=True),
        default=lambda: datetime.now(timezone.utc)
    )

    # Relation vers l'utilisateur
    user: Mapped["User"] = relationship("User")