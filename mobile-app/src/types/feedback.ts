// src/types/feedback.ts
import { StatusCode } from "@/types/status";

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
