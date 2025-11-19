// src/services/accountService.ts
import api from '@/config/api';
import { AccountResponse } from '@/types/account';

const ACCOUNT_BASE = '/accounts';

export const accountService = {
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

  create: async (payload: AccountResponse) => {
    const res = await api.post(`${ACCOUNT_BASE}/`, payload);
    return res.data;
  },

  update: async (id: number, payload: AccountResponse) => {
    const res = await api.put(`${ACCOUNT_BASE}/${id}`, payload);
    return res.data;
  },

  delete: async (id: number) => {
    const res = await api.delete(`${ACCOUNT_BASE}/${id}`);
    return res.data;
  },
};
