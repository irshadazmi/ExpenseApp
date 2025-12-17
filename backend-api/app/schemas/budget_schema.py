from typing import List, Optional
from datetime import datetime
from pydantic import BaseModel, ConfigDict


# -------------------------
# Base
# -------------------------
class BudgetBaseSchema(BaseModel):
    name: str
    amount: float
    currency: str
    period: str
    effective_from: Optional[datetime] = None
    effective_to: Optional[datetime] = None
    category_id: Optional[int] = None
    user_id: int
    version: int
    is_active: bool

    model_config = ConfigDict(from_attributes=True)


# -------------------------
# Create
# -------------------------
class BudgetCreateSchema(BudgetBaseSchema):
    created_at: Optional[datetime] = None
    updated_at: Optional[datetime] = None


# -------------------------
# Update
# -------------------------
class BudgetUpdateSchema(BudgetBaseSchema):
    updated_at: Optional[datetime] = None


# -------------------------
# Response
# -------------------------
class BudgetResponseSchema(BudgetBaseSchema):
    id: int
    created_at: datetime
    updated_at: Optional[datetime]


# -------------------------
# Snapshot (UI → API)
# -------------------------
class BudgetSnapshotItemSchema(BaseModel):
    id: int
    name: str
    amount: float
    category_id: Optional[int] = None


# -------------------------
# Save All Payload
# -------------------------
class SaveAllBudgetsSchema(BaseModel):
    user_id: int
    budgets: List[BudgetSnapshotItemSchema]
