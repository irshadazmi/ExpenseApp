# app/models/transaction_model.py
from sqlalchemy import Integer, Numeric, String, DateTime, func
from sqlalchemy.orm import declarative_base, Mapped, mapped_column, relationship
from app.models.category_model import CategoryModel

Base = declarative_base()
class TransactionModel(Base):
    __tablename__ = "transactions"
    
    id: Mapped[int] = mapped_column(Integer, primary_key=True, index=True)
    description: Mapped[str] = mapped_column(String(255), nullable=False)
    amount: Mapped[float] = mapped_column(Numeric(10, 2), nullable=False)
    type: Mapped[str] = mapped_column(String(255), nullable=False)
    currency: Mapped[str] = mapped_column(String(10), nullable=False)
    category_id: Mapped[int] = mapped_column(Integer, nullable=False)
    account_id: Mapped[int] = mapped_column(Integer, nullable=False)
    user_id: Mapped[int] = mapped_column(Integer, nullable=False)
    transaction_date: Mapped[DateTime] = mapped_column(DateTime(timezone=True), nullable=False)
    created_at: Mapped[DateTime] = mapped_column(DateTime(timezone=True), server_default=func.now())
    updated_at: Mapped[DateTime] = mapped_column(DateTime(timezone=True), onupdate=func.now())
