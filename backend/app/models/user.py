import uuid
from datetime import datetime, timezone
from sqlalchemy import String, Boolean, DateTime, ForeignKey, ARRAY
from sqlalchemy.dialects.postgresql import UUID
from sqlalchemy.orm import Mapped, mapped_column, relationship
from app.db.base import Base


class User(Base):
    """
    Table 'users' — contient tous les utilisateurs de la plateforme.
    Un utilisateur peut être patient, médecin, ou admin.
    Le rôle détermine ce à quoi il a accès.
    """
    __tablename__ = "users"

    # Identifiant unique généré automatiquement (UUID v4)
    id: Mapped[uuid.UUID] = mapped_column(
        UUID(as_uuid=True), primary_key=True, default=uuid.uuid4
    )
    # Numéro de téléphone — unique car c'est l'identifiant de connexion
    phone: Mapped[str] = mapped_column(String(20), unique=True, nullable=False)

    # Nom complet de l'utilisateur
    full_name: Mapped[str] = mapped_column(String(100), nullable=False)

    # Rôle : "patient" | "doctor" | "admin"
    role: Mapped[str] = mapped_column(String(20), nullable=False)

    # Langue préférée : "fr" | "wo" | "pu"
    language: Mapped[str] = mapped_column(String(5), default="fr")

    # Mot de passe hashé — nullable car login Google possible sans mdp
    password_hash: Mapped[str] = mapped_column(String(255), nullable=True)

    # Date de création du compte
    created_at: Mapped[datetime] = mapped_column(
        DateTime(timezone=True),
        default=lambda: datetime.now(timezone.utc)
    )

    # Relations vers les autres tables
    doctor_profile: Mapped["Doctor"] = relationship(
        "Doctor", back_populates="user", uselist=False
    )
    refresh_tokens: Mapped[list["RefreshToken"]] = relationship(
        "RefreshToken", back_populates="user"
    )


class Doctor(Base):
    """
    Table 'doctors' — profil médecin lié à un utilisateur.
    Créée uniquement quand role == "doctor".
    Contient les infos professionnelles du médecin.
    """
    __tablename__ = "doctors"

    id: Mapped[uuid.UUID] = mapped_column(
        UUID(as_uuid=True), primary_key=True, default=uuid.uuid4
    )

    # Clé étrangère vers users — si l'utilisateur est supprimé, le profil aussi
    user_id: Mapped[uuid.UUID] = mapped_column(
        UUID(as_uuid=True),
        ForeignKey("users.id", ondelete="CASCADE"),
        nullable=False
    )

    # Spécialité médicale (généraliste, cardiologue, etc.)
    specialty: Mapped[str] = mapped_column(String(100), nullable=False)

    # Numéro CNOM — Conseil National de l'Ordre des Médecins du Sénégal
    cnom_number: Mapped[str] = mapped_column(String(50), unique=True, nullable=False)

    # Langues parlées par le médecin — tableau PostgreSQL ex: ["fr", "wo"]
    languages: Mapped[list] = mapped_column(ARRAY(String), default=list)

    # Disponibilité en temps réel — toggle on/off depuis le dashboard
    is_available: Mapped[bool] = mapped_column(Boolean, default=False)

    # URL de la photo de profil
    photo_url: Mapped[str] = mapped_column(String(255), nullable=True)

    # Relation inverse vers User
    user: Mapped["User"] = relationship("User", back_populates="doctor_profile")


class RefreshToken(Base):
    """
    Table 'refresh_tokens' — stocke les tokens de rafraîchissement actifs.
    On ne stocke pas le token lui-même mais son hash SHA256
    pour des raisons de sécurité — si la DB est volée les tokens sont inutilisables.
    """
    __tablename__ = "refresh_tokens"

    id: Mapped[uuid.UUID] = mapped_column(
        UUID(as_uuid=True), primary_key=True, default=uuid.uuid4
    )

    # Utilisateur propriétaire du token
    user_id: Mapped[uuid.UUID] = mapped_column(
        UUID(as_uuid=True),
        ForeignKey("users.id", ondelete="CASCADE"),
        nullable=False
    )

    # Hash SHA256 du token — jamais le token brut
    token_hash: Mapped[str] = mapped_column(String(255), nullable=False)

    # Date d'expiration du token
    expires_at: Mapped[datetime] = mapped_column(DateTime(timezone=True), nullable=False)

    # Token révoqué ? (après logout ou rotation)
    is_revoked: Mapped[bool] = mapped_column(Boolean, default=False)

    # Relation inverse vers User
    user: Mapped["User"] = relationship("User", back_populates="refresh_tokens")