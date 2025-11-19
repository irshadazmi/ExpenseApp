# app/routers/feedback_router.py
from typing import Optional
from fastapi import APIRouter, Depends
from sqlalchemy.ext.asyncio import AsyncSession
from app.core.database import get_db
from app.repositories.feedback_repository import FeedbackRepository
from app.schemas.feedback_schema import FeedbackResponseSchema
from app.services.feedback_service import FeedbackService
from app.utils.exceptions import InternalServerErrorException, RecordNotFoundException

feedback_router = APIRouter()


@feedback_router.get("/", response_model=list[FeedbackResponseSchema])
async def get_all_feedbacks(
    skip: int = 0,
    limit: int = 10,
    user_id: Optional[int] = None,     # 🔹 NEW
    session: AsyncSession = Depends(get_db),
):
    feedback_repo = FeedbackRepository(session)
    feedback_service = FeedbackService(feedback_repo)

    try:
        return await feedback_service.get_all_feedbacks(skip, limit, user_id)
    except RecordNotFoundException as e:
        # Either re-raise or return []
        raise e
    except Exception as e:
        raise InternalServerErrorException("Failed to get feedbacks " + str(e))


@feedback_router.get("/{feedback_id}", response_model=FeedbackResponseSchema)
async def get_feedback_by_id(feedback_id: int, session: AsyncSession = Depends(get_db)):
    feedback_repo = FeedbackRepository(session)
    feedback_service = FeedbackService(feedback_repo)

    try:
        return await feedback_service.get_feedback_by_id(feedback_id)
    except RecordNotFoundException as e:
        raise e
    except Exception as e:
        raise InternalServerErrorException("Failed to get feedback " + str(e))


@feedback_router.post("/", response_model=FeedbackResponseSchema)
async def create_feedback(
    feedback: FeedbackResponseSchema,
    session: AsyncSession = Depends(get_db),
):
    feedback_repo = FeedbackRepository(session)
    feedback_service = FeedbackService(feedback_repo)

    try:
        return await feedback_service.create_feedback(feedback)
    except RecordNotFoundException as e:
        raise e
    except Exception as e:
        raise InternalServerErrorException("Failed to create feedback " + str(e))


@feedback_router.delete("/{feedback_id}")
async def delete_feedback(feedback_id: int, session: AsyncSession = Depends(get_db)):
    feedback_repo = FeedbackRepository(session)
    feedback_service = FeedbackService(feedback_repo)

    try:
        return await feedback_service.delete_feedback(feedback_id)
    except RecordNotFoundException as e:
        raise e
    except Exception as e:
        raise InternalServerErrorException("Failed to delete feedback " + str(e))
