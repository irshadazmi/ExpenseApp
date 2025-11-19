// src/types/feedback.ts
import { StatusCode } from "@/types/status";

  // id: Mapped[int] = mapped_column(Integer, primary_key=True, index=True)
  //   issue_type: Mapped[str] = mapped_column(String(100), nullable=False)
  //   subject: Mapped[str] = mapped_column(String(255), nullable=False)
  //   description: Mapped[str] = mapped_column(Text, nullable=False)
  //   rating: Mapped[int | None] = mapped_column(Integer, nullable=True) 
  //   status: Mapped[str] = mapped_column(String(50), nullable=False, default="open")
  //   user_id: Mapped[int | None] = mapped_column(Integer, nullable=True, index=True)
  //   reply: Mapped[str | None] = mapped_column(Text, nullable=True)
  //   created_at: Mapped[DateTime] = mapped_column(DateTime(timezone=True), server_default=func.now())
  //   updated_at: Mapped[DateTime] = mapped_column(DateTime(timezone=True), onupdate=func.now())

export interface FeedbackCreate {
  id: number;
  issue_type: string;
  subject: string;
  description: string;
  rating: number;
  status: StatusCode;
  reply?: string | null;
  user_id: number;
  created_at: string;
}

export interface FeedbackUpdate {
  id?: number;
  issue_type?: string;
  subject?: string;
  description?: string;
  rating?: number;
  status?: StatusCode;   // <- important
  reply?: string | null;
  user_id?: number;
  updated_at?: string;
}

export interface FeedbackResponse {
  id: number;
  issue_type: string;
  subject: string;
  description: string;
  rating: number;
  status: StatusCode;
  user_id: number;
  reply?: string | null;
  created_at: string;
  updated_at?: string;
}
