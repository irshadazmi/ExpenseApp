from typing import Optional
from pydantic import BaseModel, Field
from datetime import datetime 

class BudgetBaseSchema(BaseModel):
    name: str
    amount: float
    currency: str
    period: str
    start_date: datetime
    end_date: datetime
    category_id: int
    user_id: int
    is_active: bool

class BudgetCreateSchema(BudgetBaseSchema):
    created_at: Optional[datetime] = Field(default_factory=datetime.now)
    updated_at: Optional[datetime] = Field(default_factory=datetime.now)

    model_config = {
        "from_attributes": True,
        "json_schema_extra": {
            "example": {
                "name": "Savings Budget",
                "amount": 100000,
                "currency": "INR",
                "period": "Monthly",
                "start_date": "2023-01-01",
                "end_date": "2023-01-31",
                "category_id": 1,
                "user_id": 1,
                "created_at": "2023-01-01",
                "updated_at": "2023-01-01"
            }
        }
    }

class BudgetUpdateSchema(BudgetBaseSchema):
    updated_at: Optional[datetime] = None

    model_config = {
        "from_attributes": True,
        "json_schema_extra": {
            "example": {
                "name": "Savings Budget",
                "amount": 100000,
                "currency": "INR",
                "period": "Monthly",
                "start_date": "2023-01-01",
                "end_date": "2023-01-31",
                "category_id": 1,
                "user_id": 1,
                "updated_at": "2023-01-01"
            }
        }
    }

class BudgetResponseSchema(BudgetBaseSchema):
    id: int
    created_at: datetime
    updated_at: Optional[datetime]


