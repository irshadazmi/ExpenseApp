// mobile-app/src/services/ai-service.ts

import api from "@/config/api";
import type {
  AIChatRequest,
  AIChatResponse,
  AICategorizeRequest,
  AICategorizeResponse,
  AIInsight
} from "@/types/ai";

/* =====================================================
    BASE ROUTE
===================================================== */

const BASE = "/ai";

/* =====================================================
    AI SERVICE
===================================================== */

export const aiService = {

  /* -------------------------------
        CHAT
  -------------------------------- */

  chat: async (
    user_id: number,
    question: string
  ) =>
    (
      await api.post<AIChatResponse>(
        `${BASE}/chat`,
        {
          user_id,
          question,
        } as AIChatRequest
      )
    ).data,


  /* -------------------------------
        AUTO CATEGORIZE
  -------------------------------- */

  categorize: async (
    description: string
  ) =>
    (
      await api.post<AICategorizeResponse>(
        `${BASE}/categorize`,
        {
          description,
        } as AICategorizeRequest
      )
    ).data,



  /* -------------------------------
        INSIGHTS (FUTURE PHASE)
  -------------------------------- */

  getInsights: async (
    user_id: number,
    year?: number,
    month?: number
  ) =>
    (
      await api.get<AIInsight[]>(
        `${BASE}/insights`,
        {
          params: {
            user_id,
            year,
            month,
          },
        }
      )
    ).data
};
