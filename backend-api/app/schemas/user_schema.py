from typing import Optional
from pydantic import BaseModel, EmailStr, Field, field_validator
from app.utils.exceptions import PasswordMismatchException
from datetime import datetime 

class UserBaseSchema(BaseModel):
    email: EmailStr
    phone: str
    role_id: int = 3
    is_active: bool = Field(True)

class UserCreateSchema(UserBaseSchema):
    password: str = Field(..., min_length=8, max_length=72)
    confirm_password: str = Field(..., min_length=8, max_length=72)
    created_at: Optional[datetime] = Field(default_factory=datetime.now)
    updated_at: Optional[datetime] = Field(default_factory=datetime.now)

    @field_validator("confirm_password", mode="after")
    def check_password_match(cls, confirm_password: str, info):
        if info.data.get("password") != confirm_password:
            raise PasswordMismatchException("Passwords do not match")
        return confirm_password

    model_config = {
        "from_attributes": True,
        "json_schema_extra": {
            "example": {
                "email": "jdoe@example.com",
                "password": "password123",
                "confirm_password": "password123",
                "phone": "1234567890",
                "role_id": 3,
                "is_active": True
            }
        }
    }

class UserUpdateSchema(UserBaseSchema):
    password: str
    confirm_password: str
    updated_at: Optional[datetime] = None

    @field_validator("confirm_password", mode="after")
    def check_password_match(cls, confirm_password: str, info):
        if info.data.get("password") != confirm_password:
            raise PasswordMismatchException("Passwords do not match")
        return confirm_password

    model_config = {
        "from_attributes": True,
        "json_schema_extra": {
            "example": {
                "email": "jdoe@example.com",
                "password": "password123",
                "confirm_password": "password123",
                "phone": "1234567890",
                "role_id": 3,
                "is_active": True
            }
        }
    }

class UserResponseSchema(UserBaseSchema):
    id: int
    created_at: datetime
    updated_at: Optional[datetime]


