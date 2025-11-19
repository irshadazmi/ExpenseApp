// src/services/expenseService.ts
import api from '@/config/api';
import {
  ExpenseCreate,
  ExpenseResponse,
  ExpenseUpdate,
} from '@/types/expense'; // create later if not available

const EXPENSE_BASE = '/expenses';

export const expenseService = {
  getByUser: async (userId: number) => {
    const res = await api.get<ExpenseResponse[]>(`${EXPENSE_BASE}/`, {
      params: { user_id: userId },
    });
    console.log("getByUser", res.data);
    return res.data;
  },

  getAll: async (skip = 0, limit = 10) => {
    const res = await api.get<ExpenseResponse[]>(`${EXPENSE_BASE}/`, {
      params: { skip, limit },
    });
    return res.data;
  },

  getById: async (id: number) => {
    const res = await api.get<ExpenseResponse>(`${EXPENSE_BASE}/${id}`);
    return res.data;
  },

  create: async (payload: ExpenseCreate) => {
    const res = await api.post(`${EXPENSE_BASE}/`, payload);
    return res.data;
  },

  update: async (id: number, payload: ExpenseUpdate) => {
    const res = await api.put(`${EXPENSE_BASE}/${id}`, payload);
    return res.data;
  },

  delete: async (id: number) => {
    const res = await api.delete(`${EXPENSE_BASE}/${id}`);
    return res.data;
  },

  groupedByCategory: async () => {
    const res = await api.get(`${EXPENSE_BASE}/grouped-by-category`);
    return res.data;
  },

  summaryByCategory: async () => {
    const res = await api.get(`${EXPENSE_BASE}/summary-by-category`);
    return res.data;
  },
};
