from sqlalchemy import func, extract, select
from app.models.transaction_model import TransactionModel
from app.models.category_model import CategoryModel


class AnomalyEngine:
    def __init__(self, db):
        self.db = db

    async def detect_monthly_anomalies(self, user_id: int, year: int, month: int):
        anomalies = []

        stmt = (
            select(
                CategoryModel.id,
                CategoryModel.name,
                func.sum(TransactionModel.amount).label("total"),
                func.avg(TransactionModel.amount).label("avg_txn"),
            )
            .join(CategoryModel, CategoryModel.id == TransactionModel.category_id)
            .where(
                TransactionModel.user_id == user_id,
                TransactionModel.type == "Expense",
                extract("year", TransactionModel.transaction_date) == year,
                extract("month", TransactionModel.transaction_date) == month,
            )
            .group_by(CategoryModel.id, CategoryModel.name)
        )

        rows = (await self.db.execute(stmt)).all()

        for cid, name, total, avg_txn in rows:
            if avg_txn and total > avg_txn * 3:
                anomalies.append({
                    "insight_type": "ANOMALY",
                    "title": f"Unusual {name} spending",
                    "message": (
                        f"Your spending in {name} is significantly higher "
                        f"than your usual pattern."
                    ),
                    "severity": "HIGH",
                    "category_id": cid,
                    "confidence": 0.75,
                    "metadata": {
                        "total": float(total),
                        "avg_txn": float(avg_txn),
                    }
                })

        return anomalies
