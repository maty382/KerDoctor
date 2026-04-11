import os
import uuid
import json
import httpx
from pathlib import Path
from fastapi import UploadFile, HTTPException
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select, desc

from BACKEND.app.models.triage import Triage
from BACKEND.app.models.user import User
from BACKEND.app.core.config import get_settings

settings = get_settings()

AUDIO_DIR = Path("audio_uploads")
AUDIO_DIR.mkdir(exist_ok=True)


async def transcribe_audio(audio_path: str, language: str) -> str:
    try:
        from faster_whisper import WhisperModel
        model = WhisperModel("base", device="cpu", compute_type="int8")
        segments, info = model.transcribe(
            audio_path,
            language=None,
            beam_size=5,
            vad_filter=True,
        )
        transcript = " ".join([segment.text for segment in segments])
        return transcript.strip()
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Erreur transcription : {str(e)}")


async def analyze_with_groq(transcript: str, language: str) -> dict:
    system_prompt = """Tu es un assistant médical de triage pour KërDoctor.
    Réponds UNIQUEMENT en JSON avec ce format :
    {
        "urgency_level": 2,
        "summary": "résumé des symptômes",
        "advice": "conseils immédiats"
    }
    Niveaux : 1=CRITIQUE, 2=CONSULTATION 24-48h, 3=CONSEILS suffisants.
    Réponds dans la langue du patient."""

    try:
        async with httpx.AsyncClient(timeout=30.0) as client:
            response = await client.post(
                "https://api.groq.com/openai/v1/chat/completions",
                headers={
                    "Authorization": f"Bearer {settings.groq_api_key}",
                    "Content-Type": "application/json",
                },
                json={
                    "model": "llama-3.1-8b-instant",
                    "messages": [
                        {"role": "system", "content": system_prompt},
                        {"role": "user", "content": f"Symptômes : {transcript}"},
                    ],
                    "temperature": 0.3,
                    "max_tokens": 500,
                    "response_format": {"type": "json_object"},
                }
            )

        if response.status_code != 200:
            raise HTTPException(
                status_code=500,
                detail=f"Erreur Groq {response.status_code}: {response.text}"
            )

        content = response.json()["choices"][0]["message"]["content"]
        result = json.loads(content)

        return {
            "urgency_level": int(result.get("urgency_level", 3)),
            "summary": result.get("summary", "Analyse non disponible"),
            "advice": result.get("advice", "Consultez un médecin si les symptômes persistent"),
        }

    except json.JSONDecodeError:
        raise HTTPException(status_code=500, detail="Erreur analyse IA — JSON invalide")
    except HTTPException:
        raise
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Erreur Groq : {str(e)}")


async def process_voice_triage(
    audio_file: UploadFile,
    language: str,
    current_user: User,
    session: AsyncSession
) -> Triage:
    audio_filename = f"{uuid.uuid4()}.wav"
    audio_path = AUDIO_DIR / audio_filename

    try:
        with open(audio_path, "wb") as f:
            while chunk := await audio_file.read(1024 * 1024):
                f.write(chunk)
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Erreur sauvegarde audio : {str(e)}")

    try:
        transcript = await transcribe_audio(str(audio_path), language)

        if not transcript:
            raise HTTPException(
                status_code=400,
                detail="Audio vide ou inaudible — réenregistre ton message"
            )

        ai_result = await analyze_with_groq(transcript, language)

        triage = Triage(
            user_id=current_user.id,
            audio_url=str(audio_path),
            transcript=transcript,
            urgency_level=ai_result["urgency_level"],
            summary=ai_result["summary"],
            advice=ai_result["advice"],
            language=language,
        )
        session.add(triage)
        await session.flush()

        if ai_result["urgency_level"] == 1:
            print(f"🚨 URGENCE CRITIQUE — Patient {current_user.id} — {transcript[:100]}")

        return triage

    finally:
        if audio_path.exists():
            os.remove(audio_path)


async def get_triage_history(
    current_user: User,
    session: AsyncSession,
    limit: int = 10
) -> dict:
    result = await session.execute(
        select(Triage)
        .where(Triage.user_id == current_user.id)
        .order_by(desc(Triage.created_at))
        .limit(limit)
    )
    triages = result.scalars().all()
    return {
        "triages": triages,
        "total": len(triages)
    }