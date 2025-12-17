# app/models/feedback_model.py
from sqlalchemy import Integer, String, Text, DateTime, func
from sqlalchemy.orm import declarative_base, Mapped, mapped_column

Base = declarative_base()

class FeedbackModel(Base):
    __tablename__ = "feedbacks"
    
    id: Mapped[int] = mapped_column(Integer, primary_key=True, index=True)
    issue_type: Mapped[str] = mapped_column(String(100), nullable=False)
    subject: Mapped[str] = mapped_column(String(255), nullable=False)
    description: Mapped[str] = mapped_column(Text, nullable=False)
    rating: Mapped[int | None] = mapped_column(Integer, nullable=True) 
    status: Mapped[str] = mapped_column(String(50), nullable=False, default="Open")
    user_id: Mapped[int | None] = mapped_column(Integer, nullable=True, index=True)
    reply: Mapped[str | None] = mapped_column(Text, nullable=True)
    created_at: Mapped[DateTime] = mapped_column(DateTime(timezone=True), server_default=func.now())
    updated_at: Mapped[DateTime] = mapped_column(DateTime(timezone=True), onupdate=func.now())
