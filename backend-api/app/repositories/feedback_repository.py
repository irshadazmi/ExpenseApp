# app/repositories/feedback_repository.py
from datetime import datetime
from typing import Optional

from sqlalchemy import select

from app.schemas.feedback_schema import FeedbackCreateSchema, FeedbackUpdateSchema
from app.models.feedback_model import FeedbackModel
from app.utils.exceptions import (
    FailedToCreateException,
    FailedToDeleteException,
    FailedToUpdateException,
    RecordNotFoundException,
)


class FeedbackRepository:
    def __init__(self, db):
        self.db = db

    async def get_all_feedbacks(self, user_id: Optional[int] = None):
        stmt = select(FeedbackModel)

        if user_id is not None:
            stmt = stmt.where(FeedbackModel.user_id == user_id)

        result = await self.db.execute(stmt)
        rows = result.scalars().all()

        if not result:
            return []
            # raise RecordNotFoundException("No feedback records found")

        return rows

    async def get_feedback_by_id(self, feedback_id: int):
        result = await self.db.execute(
            select(FeedbackModel).where(FeedbackModel.id == feedback_id)
        )
        feedback = result.scalars().first()
        if not feedback:
            raise RecordNotFoundException("Feedback not found")
        return feedback

    async def create_feedback(self, feedback: FeedbackCreateSchema) -> FeedbackModel:
        db_feedback = FeedbackModel(**feedback.dict(exclude_unset=True))

        try:
            self.db.add(db_feedback)
            await self.db.commit()
            await self.db.refresh(db_feedback)
            return db_feedback
        except Exception as e:
            await self.db.rollback()
            raise FailedToCreateException(detail=str(e))

    async def update_feedback(
        self, feedback_id: int, feedback_data: FeedbackUpdateSchema
    ) -> FeedbackModel:
        result = await self.db.execute(
            select(FeedbackModel).where(FeedbackModel.id == feedback_id)
        )
        feedback = result.scalars().first()

        if not feedback:
            raise RecordNotFoundException("Feedback not found")

        update_data = feedback_data.dict(exclude_unset=True)
        for key, value in update_data.items():
            setattr(feedback, key, value)

        try:
            feedback.updated_at = datetime.utcnow()
            await self.db.commit()
            await self.db.refresh(feedback)
            return feedback
        except Exception as e:
            await self.db.rollback()
            raise FailedToUpdateException(detail=str(e))

    async def delete_feedback(self, feedback_id: int):
        result = await self.db.execute(
            select(FeedbackModel).where(FeedbackModel.id == feedback_id)
        )
        feedback = result.scalars().first()
        if not feedback:
            raise RecordNotFoundException("Feedback not found")

        try:
            # 🔹 soft delete (assuming these fields exist)
            feedback.is_active = False
            feedback.updated_at = datetime.utcnow()
            await self.db.commit()
            await self.db.refresh(feedback)
            return feedback
        except Exception as e:
            await self.db.rollback()
            raise FailedToDeleteException(detail=str(e))
