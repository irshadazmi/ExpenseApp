from sqlalchemy import Float, String, Integer, Boolean, DateTime, func
from sqlalchemy.orm import declarative_base, Mapped, mapped_column, relationship

Base = declarative_base()

class BudgetModel(Base):
    __tablename__ = "budgets"

    id: Mapped[int] = mapped_column(Integer, primary_key=True, index=True)
    name: Mapped[str] = mapped_column(String(255), unique=True, nullable=False, index=True)
    amount: Mapped[float] = mapped_column(Float, default=0)
    currency: Mapped[str] = mapped_column(String(10), default="INR")
    period: Mapped[str] = mapped_column(String(50), nullable=False)
    effective_from: Mapped[DateTime] = mapped_column(DateTime(timezone=True), nullable=True)
    effective_to: Mapped[DateTime] = mapped_column(DateTime(timezone=True), nullable=True)
    category_id: Mapped[int] = mapped_column(Integer, nullable=True)
    user_id: Mapped[int] = mapped_column(Integer, nullable=False)
    version: Mapped[int] = mapped_column(Integer, nullable=False)
    is_active: Mapped[bool] = mapped_column(Boolean, default=True)
    created_at: Mapped[DateTime] = mapped_column(DateTime(timezone=True), server_default=func.now())
    updated_at: Mapped[DateTime] = mapped_column(DateTime(timezone=True), onupdate=func.now())