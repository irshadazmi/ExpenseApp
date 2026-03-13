# backend-api/app/schemas/ai_schema.py
from datetime import datetime
from pydantic import BaseModel
from typing import Dict, Literal, Optional, List


# =============================
# CHAT REQUEST / RESPONSE
# =============================

class AIChatRequest(BaseModel):
    user_id: int
    question: str


class AIChatResponse(BaseModel):
    answer: str
    sql_used: Optional[str]
    rows: List[Dict]
    voice_text: Optional[str] = None   # 🔥 NEW


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
    id: Optional[int] = None
    insight_type: Literal[
        "SUMMARY",
        "BUDGET_STATUS",
        "BUDGET_FORECAST",
        "ANOMALY"
    ]
    title: str
    message: str
    severity: Literal["LOW", "MEDIUM", "HIGH"]
    category_id: Optional[int] = None
    metadata: dict = {}
    confidence: Optional[float] = None
    created_at: Optional[datetime] = None
