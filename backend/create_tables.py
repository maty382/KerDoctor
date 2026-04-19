import asyncio
from app.db.base import engine, Base
from app.models.user import User, Doctor, RefreshToken
from app.models.triage import Triage

async def create():
    async with engine.begin() as conn:
        await conn.run_sync(Base.metadata.create_all)
    print("Tables créées avec succès !")

asyncio.run(create())