// src/services/feedbackService.ts
import api from '@/config/api';
import { FeedbackResponse } from '@/types/feedback';

const API_BASE = '/feedbacks'; // base

export const feedbackService = {
  getByUser: async (userId: number) => {
    const res = await api.get<FeedbackResponse[]>(`${API_BASE}/`, {
      params: { user_id: userId },
    });
    return res.data;
  },

  getAll: async () => {
    const res = await api.get<FeedbackResponse[]>(`${API_BASE}/`);
    return res.data;
  },

  getById: async (id: number) => {
    const res = await api.get<FeedbackResponse>(`${API_BASE}/${id}`);
    return res.data;
  },

  create: async (payload: FeedbackResponse) => {
    const res = await api.post<FeedbackResponse>(`${API_BASE}/`, payload);
    return res.data;
  },

  update: async (id: number, payload: FeedbackResponse) => {
    const res = await api.put<FeedbackResponse>(`${API_BASE}/${id}`, payload);
    return res.data;
  },

  delete: async (id: number) => {
    const res = await api.delete(`${API_BASE}/${id}`);
    return res.data;
  },
};
