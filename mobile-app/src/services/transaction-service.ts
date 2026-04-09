// src/services/transactionService.ts
import api from '@/config/api';
import {
  TransactionCreate,
  TransactionResponse,
  TransactionUpdate,
} from '@/types/transaction'; // create later if not available

const API_BASE = '/transactions';

export const transactionService = {
  getByUser: async (userId: number) => {
    const res = await api.get<TransactionResponse[]>(`${API_BASE}/`, {
      params: { user_id: userId },
    });
    return res.data;
  },

  getAll: async (skip = 0, limit = 10) => {
    const res = await api.get<TransactionResponse[]>(`${API_BASE}/`, {
      params: { skip, limit },
    });
    return res.data;
  },

  getById: async (id: number) => {
    const res = await api.get<TransactionResponse>(`${API_BASE}/${id}`);
    return res.data;
  },

  create: async (payload: TransactionCreate) => {
    const res = await api.post(`${API_BASE}/`, payload);
    return res.data;
  },

  update: async (id: number, payload: TransactionUpdate) => {
    const res = await api.put(`${API_BASE}/${id}`, payload);
    return res.data;
  },

  delete: async (id: number) => {
    const res = await api.delete(`${API_BASE}/${id}`);
    return res.data;
  },

  groupedByCategory: async () => {
    const res = await api.get(`${API_BASE}/grouped-by-category`);
    return res.data;
  },

  summaryByCategory: async () => {
    const res = await api.get(`${API_BASE}/summary-by-category`);
    return res.data;
  },
};
