from typing import Optional
from pydantic import BaseModel, Field
from datetime import datetime 

class AccountBaseSchema(BaseModel):
    name: str
    type: str
    balance: float
    currency: str
    user_id: int
    is_active: bool

class AccountCreateSchema(AccountBaseSchema):
    created_at: Optional[datetime] = Field(default_factory=datetime.now)
    updated_at: Optional[datetime] = None

    model_config = {
        "from_attributes": True,
        "json_schema_extra": {
            "example": {
                "name": "Savings Account",
                "type": "Savings",
                "balance": 100000,
                "currency": "INR",
                "user_id": 1,
                "is_active": True,
                "created_at": "2023-01-01",
                "updated_at": "2023-01-01"
            }
        }
    }

class AccountUpdateSchema(AccountBaseSchema):
    updated_at: Optional[datetime] = Field(default_factory=datetime.now)

    model_config = {
        "from_attributes": True,
        "json_schema_extra": {
            "example": {
                "name": "Savings Account",
                "type": "Savings",
                "balance": 100000,
                "currency": "INR",
                "user_id": 1,
                "is_active": True,
                "updated_at": "2023-01-01"
            }
        }
    }

class AccountResponseSchema(AccountBaseSchema):
    id: int
    created_at: datetime
    updated_at: Optional[datetime]


