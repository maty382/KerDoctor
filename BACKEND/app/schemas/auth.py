from pydantic import BaseModel, field_validator
from typing import Optional
import re


class RegisterRequest(BaseModel):
    phone: str
    full_name: str
    password: str
    role: str = "patient"
    language: str = "fr"
    specialty: Optional[str] = None
    cnom_number: Optional[str] = None
    languages: Optional[list[str]] = None

    @field_validator("phone")
    @classmethod
    def validate_phone(cls, v):
        if not re.match(r"^\+?[0-9]{8,15}$", v):
            raise ValueError("Numéro de téléphone invalide")
        return v

    @field_validator("role")
    @classmethod
    def validate_role(cls, v):
        if v not in ("patient", "doctor"):
            raise ValueError("Le rôle doit être 'patient' ou 'doctor'")
        return v

    @field_validator("password")
    @classmethod
    def validate_password(cls, v):
        if len(v) < 8:
            raise ValueError("Le mot de passe doit contenir au moins 8 caractères")
        return v


class LoginRequest(BaseModel):
    phone: str
    password: str


class RefreshRequest(BaseModel):
    refresh_token: str


class TokenResponse(BaseModel):
    access_token: str
    refresh_token: str
    token_type: str = "bearer"
    user_id: str
    role: str
    full_name: str


class UserResponse(BaseModel):
    id: str
    phone: str
    full_name: str
    role: str
    language: str

    @field_validator("id", mode="before")
    @classmethod
    def convert_uuid_to_str(cls, v):
        # Convertit l'UUID PostgreSQL en string pour la réponse JSON
        return str(v)

    class Config:
        from_attributes = True