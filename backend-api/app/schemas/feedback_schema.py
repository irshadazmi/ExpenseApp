from typing import Optional
from pydantic import BaseModel, Field
from datetime import datetime 

class FeedbackBaseSchema(BaseModel):
    issue_type: str
    subject: str
    description: str
    rating: int
    status: str
    user_id: int
    reply: Optional[str] = None

class FeedbackCreateSchema(FeedbackBaseSchema):
    created_at: Optional[datetime] = Field(default_factory=datetime.now)
    updated_at: Optional[datetime] = Field(default_factory=datetime.now)

    model_config = {
        "from_attributes": True,
        "json_schema_extra": {
            "example": {
                "name": "Savings Feedback",
                "issue_type": "Savings",
                "subject": "Savings Account",
                "description": "Weekly groceries from local store",
                "rating": 5,
                "status": "Open",
                "user_id": 1,
                "reply": "Thanks for your feedback",
                "created_at": "2023-01-01",
                "updated_at": "2023-01-01"
            }
        }
    }

class FeedbackUpdateSchema(FeedbackBaseSchema):
    updated_at: Optional[datetime] = None

    model_config = {
        "from_attributes": True,
        "json_schema_extra": {
            "example": {
                "name": "Savings Feedback",
                "issue_type": "Savings",
                "subject": "Savings Account",
                "description": "Weekly groceries from local store",
                "rating": 5,
                "status": "Open",
                "user_id": 1,
                "reply": "Thanks for your feedback",
                "updated_at": "2023-01-01"
            }
        }
    }

class FeedbackResponseSchema(FeedbackBaseSchema):
    id: int
    created_at: datetime
    updated_at: Optional[datetime]


