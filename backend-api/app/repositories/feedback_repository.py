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

        if not rows:
            return []

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

    async def update_feedback(self, feedback_id: int, feedback_data: dict):
        result = await self.db.execute(select(FeedbackModel).where(FeedbackModel.id == feedback_id))
        existing_feedback = result.scalars().first()

        if not existing_feedback:
            raise RecordNotFoundException("Feedback not found")

        # update_data = feedback_data.dict(exclude_unset=True)
        for key, value in feedback_data.items():
            setattr(existing_feedback, key, value)

        try:
            existing_feedback.updated_at = datetime.utcnow()
            await self.db.commit()
            await self.db.refresh(existing_feedback)
            return existing_feedback
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
            feedback.is_active = False
            feedback.updated_at = datetime.utcnow()
            await self.db.commit()
            await self.db.refresh(feedback)
            return feedback
        except Exception as e:
            await self.db.rollback()
            raise FailedToDeleteException(detail=str(e))
