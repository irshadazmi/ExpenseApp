from fastapi import APIRouter, Depends, Query
from sqlalchemy.ext.asyncio import AsyncSession

from app.core.database import get_db
from app.repositories.ai_repository import AIRepository
from app.services.ai_service import AIService
from app.schemas.ai_schema import (
    AIChatRequest,
    AIChatResponse,
    AICategorizeRequest,
    AICategorizeResponse,
)

ai_router = APIRouter()


# ============================================================
# Dependency
# ============================================================

def get_ai_service(db: AsyncSession = Depends(get_db)) -> AIService:
    repo = AIRepository(db)
    return AIService(repo)


# ============================================================
# CHAT
# ============================================================

@ai_router.post("/chat", response_model=AIChatResponse)
async def chat(
    payload: AIChatRequest,
    service: AIService = Depends(get_ai_service),
):
    return await service.chat(
        user_id=payload.user_id,
        question=payload.question,
    )


# ============================================================
# CATEGORIZE
# ============================================================

@ai_router.post("/categorize", response_model=AICategorizeResponse)
async def categorize(
    payload: AICategorizeRequest,
    service: AIService = Depends(get_ai_service),
):
    return await service.categorize(payload.description)

# ============================================================
# INSIGHTS
# ============================================================

@ai_router.get("/insights")
async def insights(
    user_id: int = Query(...),
    service: AIService = Depends(get_ai_service),
):
    return await service.generate_insights(user_id)
