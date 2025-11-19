from typing import Optional
from pydantic import BaseModel, Field
from datetime import datetime 

class CategoryBaseSchema(BaseModel):
    name: str
    is_active: bool

    model_config = {
        "from_attributes": True,
        "json_schema_extra": {
            "example": {
                "name": "Groceries",
                "is_active": True
            }
        }
    }

class CategoryCreateSchema(CategoryBaseSchema):
    created_at: Optional[datetime] = Field(default_factory=datetime.now)
    updated_at: Optional[datetime] = Field(default_factory=datetime.now)

    model_config = {
        "from_attributes": True,
        "json_schema_extra": {
            "example": {
                "created_at": "2023-01-01",
                "updated_at": "2023-01-01"
            }
        }
    }

class CategoryUpdateSchema(CategoryBaseSchema):
    updated_at: Optional[datetime] = None

    model_config = {
        "from_attributes": True,
        "json_schema_extra": {
            "example": {
                "updated_at": "2023-01-01"
            }
        }
    }

class CategoryResponseSchema(CategoryBaseSchema):
    id: int
    created_at: datetime
    updated_at: Optional[datetime]


