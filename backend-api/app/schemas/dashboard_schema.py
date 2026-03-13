# backend-api/app/schemas/dashboard_schema.py
from pydantic import BaseModel
from typing import List, Optional

class BudgetVsSpendSchema(BaseModel):
    total_budget: int
    total_spent: int
    remaining: int
    percent_used: float

class CategorySpendSchema(BaseModel):
    category_id: int
    category_name: str
    short_name: str
    budget_amount: int
    spent_amount: int
    remaining: int

class TransactionFeedSchema(BaseModel):
    id: int
    description: str
    amount: int
    category_id: int
    category_name: str
    short_name: str
    date: str

class AccountSummarySchema(BaseModel):
    account_id: int
    balance: int
    currency: str

class AlertSchema(BaseModel):
    category_id: int
    message: str
