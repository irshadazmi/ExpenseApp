# app/services/feedback_service.py
from typing import Optional
from app.schemas.feedback_schema import FeedbackCreateSchema, FeedbackUpdateSchema
from app.utils.exceptions import FailedToCreateException


class FeedbackService:
    def __init__(self, feedback_repository):
        self.feedback_repository = feedback_repository

    async def get_all_feedbacks(self, user_id: Optional[int] = None):
        return await self.feedback_repository.get_all_feedbacks(user_id)

    async def get_feedback_by_id(self, feedback_id: int):
        return await self.feedback_repository.get_feedback_by_id(feedback_id)

    async def create_feedback(self, feedback_data: FeedbackCreateSchema):
        if feedback_data.rating is not None and (feedback_data.rating < 1 or feedback_data.rating > 5):
            raise FailedToCreateException(detail="Rating must be between 1 and 5")

        return await self.feedback_repository.create_feedback(feedback_data)

    async def update_feedback(self, feedback_id: int, feedback_data: FeedbackUpdateSchema):
        if feedback_data.rating is not None and (feedback_data.rating < 1 or feedback_data.rating > 5):
            raise FailedToCreateException(detail="Rating must be between 1 and 5")

        return await self.feedback_repository.update_feedback(feedback_id, feedback_data)

    async def delete_feedback(self, feedback_id: int):
        return await self.feedback_repository.delete_feedback(feedback_id)
