// src/services/feedbackService.ts
import api from '@/config/api';
import { FeedbackResponse } from '@/types/feedback';

const FEEDBACK_BASE = '/feedbacks'; // base

export const feedbackService = {
  getByUser: async (userId: number) => {
    const res = await api.get<FeedbackResponse[]>(`${FEEDBACK_BASE}/`, {
      params: { user_id: userId },
    });
    console.log("getByUser", res.data);
    return res.data;
  },

  getAll: async (skip = 0, limit = 10) => {
    const res = await api.get<FeedbackResponse[]>(`${FEEDBACK_BASE}/`, {
      params: { skip, limit },
    });
    console.log("getAll", res.data);
    return res.data;
  },

  getById: async (id: number) => {
    const res = await api.get<FeedbackResponse>(`${FEEDBACK_BASE}/${id}`);
    return res.data;
  },

  create: async (payload: FeedbackResponse) => {
    const res = await api.post<FeedbackResponse>(`${FEEDBACK_BASE}/`, payload);
    return res.data;
  },

  update: async (id: number, payload: FeedbackResponse) => {
    const res = await api.put<FeedbackResponse>(`${FEEDBACK_BASE}/${id}`, payload);
    return res.data;
  },

  delete: async (id: number) => {
    const res = await api.delete(`${FEEDBACK_BASE}/${id}`);
    return res.data;
  },
};
