# backend-api/app/schemas/insights_schema.py

from pydantic import BaseModel
from typing import Literal


class AIInsight(BaseModel):
    title: str
    severity: Literal["low", "medium", "high"]
    message: str
