// src/services/budgetService.ts
import api from '@/config/api';
import { BudgetResponse } from '@/types/budget';

const ACCOUNT_BASE = '/budgets';

export const budgetService = {
  getAll: async (skip = 0, limit = 10) => {
    const res = await api.get(`${ACCOUNT_BASE}/`, {
      params: { skip, limit },
    });
    return res.data;
  },

  getById: async (id: number) => {
    const res = await api.get(`${ACCOUNT_BASE}/${id}`);
    return res.data;
  },

  create: async (payload: BudgetResponse) => {
    const res = await api.post(`${ACCOUNT_BASE}/`, payload);
    return res.data;
  },

  update: async (id: number, payload: BudgetResponse) => {
    const res = await api.put(`${ACCOUNT_BASE}/${id}`, payload);
    return res.data;
  },

  delete: async (id: number) => {
    const res = await api.delete(`${ACCOUNT_BASE}/${id}`);
    return res.data;
  },
};
