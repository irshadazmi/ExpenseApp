# app/ai/forecast_engine.py
from datetime import date, datetime
from calendar import monthrange
from typing import List, Optional

from sqlalchemy import func, extract, select
from sqlalchemy.ext.asyncio import AsyncSession

from app.models.transaction_model import TransactionModel
from app.models.budget_model import BudgetModel
from app.models.category_model import CategoryModel


class BudgetForecastResult:
    def __init__(
        self,
        category_id: int,
        category_name: str,
        budget_amount: float,
        spent_so_far: float,
        projected_spend: float,
        days_remaining: int,
        days_to_exceed: Optional[int],
        severity: str,
        confidence: float,
    ):
        self.category_id = category_id
        self.category_name = category_name
        self.budget_amount = budget_amount
        self.spent_so_far = spent_so_far
        self.projected_spend = projected_spend
        self.days_remaining = days_remaining
        self.days_to_exceed = days_to_exceed
        self.severity = severity
        self.confidence = confidence


class ForecastEngine:
    """
    Phase-4 Forecast Engine
    Predicts end-of-month spend and budget breach risk
    """

    def __init__(self, db: AsyncSession):
        self.db = db

    async def generate_monthly_forecast(
        self,
        user_id: int,
        year: int,
        month: int,
    ) -> List[BudgetForecastResult]:

        today = date.today()
        total_days = monthrange(year, month)[1]

        if year == today.year and month == today.month:
            days_elapsed = today.day
        else:
            days_elapsed = total_days  # historical month

        days_remaining = max(total_days - days_elapsed, 0)

        # --------------------------------------------------
        # Fetch active budgets for the user
        # --------------------------------------------------
        budget_query = (
            select(
                BudgetModel.id,
                BudgetModel.amount,
                BudgetModel.category_id,
                CategoryModel.name,
            )
            .join(CategoryModel, CategoryModel.id == BudgetModel.category_id)
            .where(
                BudgetModel.user_id == user_id,
                BudgetModel.is_active == True,
                BudgetModel.period == "Monthly",
            )
        )

        budgets = (await self.db.execute(budget_query)).all()

        results: List[BudgetForecastResult] = []

        for budget_id, budget_amount, category_id, category_name in budgets:

            # ----------------------------------------------
            # Calculate spend so far
            # ----------------------------------------------
            spend_query = (
                select(func.coalesce(func.sum(TransactionModel.amount), 0))
                .where(
                    TransactionModel.user_id == user_id,
                    TransactionModel.category_id == category_id,
                    extract("year", TransactionModel.transaction_date) == year,
                    extract("month", TransactionModel.transaction_date) == month,
                    TransactionModel.type == "Expense",
                )
            )

            spent_so_far = (await self.db.execute(spend_query)).scalar() or 0

            # ----------------------------------------------
            # Forecast
            # ----------------------------------------------
            if days_elapsed == 0:
                projected_spend = 0
            else:
                daily_avg = spent_so_far / days_elapsed
                projected_spend = round(daily_avg * total_days, 2)

            # ----------------------------------------------
            # Days to budget breach
            # ----------------------------------------------
            days_to_exceed = None
            if spent_so_far < budget_amount and daily_avg > 0:
                remaining_budget = budget_amount - spent_so_far
                days_to_exceed = max(int(remaining_budget / daily_avg), 0)

            # ----------------------------------------------
            # Severity logic
            # ----------------------------------------------
            severity = self._calculate_severity(
                budget_amount=budget_amount,
                spent_so_far=spent_so_far,
                projected_spend=projected_spend,
            )

            # ----------------------------------------------
            # Confidence (simple heuristic)
            # ----------------------------------------------
            confidence = min(0.6 + (days_elapsed / total_days) * 0.4, 0.95)

            results.append(
                BudgetForecastResult(
                    category_id=category_id,
                    category_name=category_name,
                    budget_amount=budget_amount,
                    spent_so_far=spent_so_far,
                    projected_spend=projected_spend,
                    days_remaining=days_remaining,
                    days_to_exceed=days_to_exceed,
                    severity=severity,
                    confidence=round(confidence, 2),
                )
            )

        return results

    def _calculate_severity(
        self,
        budget_amount: float,
        spent_so_far: float,
        projected_spend: float,
    ) -> str:
        """
        Severity based on projected outcome, not static %
        """
        if projected_spend >= budget_amount * 1.1:
            return "HIGH"
        if projected_spend >= budget_amount * 0.9:
            return "MEDIUM"
        return "LOW"
