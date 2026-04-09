from typing import Optional
from pydantic import BaseModel, EmailStr, Field, field_validator
from app.utils.exceptions import PasswordMismatchException
from datetime import datetime 

class AuthBaseSchema(BaseModel):
    full_name: str
    email: EmailStr
    phone: str
    role_id: int = 3
    is_active: bool = Field(True)

class AuthRegisterSchema(AuthBaseSchema):
    password: str
    confirm_password: str
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
                "full_name": "John Doe",
                "email": "jdoe@example.com",   
                "password": "password123",
                "confirm_password": "password123",
                "phone": "1234567890",
                "role_id": 3,
                "is_active": True
            }
        }
    }

class AuthUpdateSchema(AuthBaseSchema):
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
                "full_name": "John Doe",
                "email": "jdoe@example.com",   
                "password": "password123",
                "confirm_password": "password123",
                "phone": "1234567890",
                "role_id": 3,
                "is_active": True
            }
        }
    }

class AuthLoginSchema(BaseModel):
    email: EmailStr
    password: str

class AuthResponseSchema(BaseModel):
    id: int
    full_name: str
    email: str
    phone: str
    role_id: int
    is_active: bool

    class Config:
        from_attributes = True

class Token(BaseModel):
    access_token: str
    token_type: str

class AuthResultSchema(BaseModel):
    user: AuthResponseSchema
    token: Token

    class Config:
        from_attributes = True

class OTPVerifyRequest(BaseModel):
    phone: str
    otp: str