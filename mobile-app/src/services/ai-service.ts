// mobile-app/src/services/ai-service.ts

import api from "@/config/api";
import axios from "axios";
import type {
  AIChatRequest,
  AIChatResponse,
  AICategorizeRequest,
  AICategorizeResponse,
  AIInsight,
  AIVoiceChatResponse
} from "@/types/ai";


/* =====================================================
      BASE ROUTE
===================================================== */

const API_BASE = "/ai";

/* =====================================================
      AI SERVICE
===================================================== */

export const aiService = {

  /* -------------------------------
        TEXT CHAT
  -------------------------------- */

  chat: async (user_id: number, question: string) =>
    (
      await api.post<AIChatResponse>(
        `${API_BASE}/chat`,
        {
          user_id,
          question,
        } as AIChatRequest
      )
    ).data,


  /* -------------------------------
        VOICE CHAT (NEW)
        Sends .wav to Whisper → AI → Response
  -------------------------------- */

  voiceChat: async (user_id: number, fileUri: string) => {
    const form = new FormData();

    form.append("user_id", String(user_id));  // 🔥 Ensures string type
    form.append("file", {
      uri: fileUri,
      name: "voice.m4a",
      type: "audio/m4a",
    } as any);

    const res = await api.post<AIVoiceChatResponse>(
      `${API_BASE}/voice-chat`,
      form,
      {
        headers: {
          "Content-Type": "multipart/form-data",
        },
      }
    );

    return res.data;
  },


  /* -------------------------------
        AUTO CATEGORIZE
  -------------------------------- */

  categorize: async (description: string) =>
    (
      await api.post<AICategorizeResponse>(
        `${API_BASE}/categorize`,
        {
          description,
        } as AICategorizeRequest
      )
    ).data,


  /* -------------------------------
        INSIGHTS
  -------------------------------- */

  getInsights: async (user_id: number, year?: number, month?: number) =>
    (
      await api.get<AIInsight[]>(
        `${API_BASE}/insights`,
        {
          params: {
            user_id,
            year,
            month,
          },
        }
      )
    ).data,
};
