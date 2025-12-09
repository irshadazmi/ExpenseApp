from fastapi import APIRouter, Depends, Query
from sqlalchemy.ext.asyncio import AsyncSession

from app.core.database import get_db
from app.repositories.ai_repository import AIRepository
from app.services.ai_service import AIService
from app.repositories.dashboard_repository import DashboardRepository
from app.services.dashboard_service import DashboardService

from app.schemas.ai_schema import *


ai_router = APIRouter()


# ============================================================
# Dependency
# ============================================================

def get_ai_service(db: AsyncSession = Depends(get_db)):

    ai_repo = AIRepository(db)

    dash_repo = DashboardRepository(db)
    dash_service = DashboardService(dash_repo)

    return AIService(ai_repo, dash_service)


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
# INSIGHTS
# ============================================================

@ai_router.get("/insights")
async def insights(
    user_id: int = Query(...),
    year: int | None = Query(None),
    month: int | None = Query(None),
    service: AIService = Depends(get_ai_service),
):
    return await service.insights(
        user_id=user_id,
        year=year,
        month=month,
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
