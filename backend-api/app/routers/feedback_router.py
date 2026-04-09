# backend-api/app/routers/feedback_router.py
from typing import Optional
from fastapi import APIRouter, Depends
from sqlalchemy.ext.asyncio import AsyncSession
from app.core.database import get_db
from app.repositories.feedback_repository import FeedbackRepository
from app.schemas.feedback_schema import FeedbackResponseSchema, FeedbackCreateSchema, FeedbackUpdateSchema
from app.services.feedback_service import FeedbackService
from app.utils.exceptions import FailedToUpdateException, InternalServerErrorException, RecordNotFoundException

feedback_router = APIRouter()

@feedback_router.get("/", response_model=list[FeedbackResponseSchema])
async def get_all_feedbacks(
    user_id: Optional[int] = None, 
    session: AsyncSession = Depends(get_db),
):
    feedback_repo = FeedbackRepository(session)
    feedback_service = FeedbackService(feedback_repo)
    return await feedback_service.get_all_feedbacks(user_id)
    
@feedback_router.get("/{feedback_id}", response_model=FeedbackResponseSchema)
async def get_feedback_by_id(feedback_id: int, session: AsyncSession = Depends(get_db)):
    feedback_repo = FeedbackRepository(session)
    feedback_service = FeedbackService(feedback_repo)
    return await feedback_service.get_feedback_by_id(feedback_id)
    
@feedback_router.post("/", response_model=FeedbackResponseSchema)
async def create_feedback(feedback: FeedbackCreateSchema, session: AsyncSession = Depends(get_db)):
    feedback_repo = FeedbackRepository(session)
    feedback_service = FeedbackService(feedback_repo)
    return await feedback_service.create_feedback(feedback)

@feedback_router.put("/{feedback_id}", response_model=FeedbackResponseSchema)
async def update_feedback(feedback_id: int, feedback: FeedbackUpdateSchema, db: AsyncSession = Depends(get_db)):
    feedback_repo = FeedbackRepository(db)
    feedback_service = FeedbackService(feedback_repo)
    try:
        return await feedback_service.update_feedback(feedback_id, feedback)
    except (RecordNotFoundException, FailedToUpdateException) as e:
        raise e
    except Exception as e:
        raise InternalServerErrorException("Failed to update feedback "+str(e))
    
@feedback_router.delete("/{feedback_id}")
async def delete_feedback(feedback_id: int, session: AsyncSession = Depends(get_db)):
    feedback_repo = FeedbackRepository(session)
    feedback_service = FeedbackService(feedback_repo)
    return await feedback_service.delete_feedback(feedback_id)