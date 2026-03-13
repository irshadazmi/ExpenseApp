from typing import Optional
from pydantic import BaseModel, Field
from datetime import datetime

class TransactionBaseSchema(BaseModel):
    description: str
    amount: float
    category_id: int
    account_id: int
    type: str
    currency: str
    user_id: int
    transaction_date: datetime

class TransactionCreateSchema(TransactionBaseSchema):
    created_at: Optional[datetime] = Field(default_factory=datetime.now)
    updated_at: Optional[datetime] = Field(default_factory=datetime.now)

    model_config = {
        "from_attributes": True,
        "json_schema_extra": {
            "example": {
                "description": "Weekly groceries from local store",
                "amount": 100,
                "category_id": 1,
                "account_id": 1,
                "type": "Expense",
                "currency": "INR",
                "user_id": 1,
                "transaction_date": "2025-09-01",
                "created_at": "2025-09-01",
                "updated_at": "2025-09-01"
            }
        }
    }

class TransactionUpdateSchema(TransactionBaseSchema):
    updated_at: Optional[datetime] = Field(default_factory=datetime.now)

    model_config = {
        "from_attributes": True,
        "json_schema_extra": {
            "example": {
                "description": "Weekly groceries from local store",
                "amount": 100,
                "category_id": 1,
                "account_id": 1,
                "type": "Expense",
                "currency": "INR",
                "user_id": 1,
                "transaction_date": "2025-09-01",
                "updated_at": "2025-09-01"
            }
        }
    }

class TransactionResponseSchema(TransactionBaseSchema):
    id: int
    created_at: datetime
    updated_at: Optional[datetime]

class CategoryTransactionSummary(BaseModel):
    category_id: int
    category_name: str
    total_amount: int
