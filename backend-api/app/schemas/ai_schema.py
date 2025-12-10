# backend-api/app/schemas/ai_schema.py
from pydantic import BaseModel
from typing import Literal, Optional, List


# =============================
# CHAT REQUEST / RESPONSE
# =============================

class AIChatRequest(BaseModel):
    user_id: int
    question: str


class AIChatResponse(BaseModel):
    answer: str
    sql_used: Optional[str] = None
    rows: Optional[List[dict]] = None


# =============================
# INSIGHTS
# =============================

class AIInsight(BaseModel):
    title: str
    severity: str   # low | medium | high
    message: str


# =============================
# AUTO CATEGORY
# =============================

class AICategorizeRequest(BaseModel):
    description: str


class AICategorizeResponse(BaseModel):
    category_id: int
    confidence: float

class AIInsight(BaseModel):
    title: str
    severity: Literal["low", "medium", "high"]
    message: str