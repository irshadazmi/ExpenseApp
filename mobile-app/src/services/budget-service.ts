// src/services/budgetService.ts
import api from '@/config/api';
import { BudgetResponse } from '@/types/budget';

const BUDGET_BASE = '/budgets';

export const budgetService = {
  getByUser: async (userId: number) => {
    const res = await api.get<BudgetResponse[]>(`${BUDGET_BASE}/`, {
      params: { user_id: userId },
    });
    console.log("getByUser", res.data);
    return res.data;
  },

  getAll: async (skip = 0, limit = 10) => {
    const res = await api.get<BudgetResponse[]>(`${BUDGET_BASE}/`, {
      params: { skip, limit },
    });
    return res.data;
  },

  getById: async (id: number) => {
    const res = await api.get<BudgetResponse>(`${BUDGET_BASE}/${id}`);
    return res.data;
  },

  create: async (payload: BudgetResponse) => {
    const res = await api.post(`${BUDGET_BASE}/`, payload);
    return res.data;
  },

  update: async (id: number, payload: BudgetResponse) => {
    const res = await api.put(`${BUDGET_BASE}/${id}`, payload);
    return res.data;
  },

  delete: async (id: number) => {
    const res = await api.delete(`${BUDGET_BASE}/${id}`);
    return res.data;
  },
};
