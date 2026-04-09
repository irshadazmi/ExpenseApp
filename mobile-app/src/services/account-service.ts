// src/services/accountService.ts
import api from '@/config/api';
import { AccountCreate, AccountResponse, AccountUpdate } from '@/types/account';

const API_BASE = '/accounts';

export const accountService = {
  getByUser: async (userId: number) => {
    const res = await api.get<AccountResponse[]>(`${API_BASE}/`, {
      params: { user_id: userId },
    });
    return res.data;
  },

  getAll: async () => {
    const res = await api.get<AccountResponse[]>(`${API_BASE}/`);
    return res.data;
  },

  getById: async (id: number) => {
    const res = await api.get<AccountResponse>(`${API_BASE}/${id}`);
    return res.data;
  },

  create: async (payload: AccountCreate) => {
    const res = await api.post(`${API_BASE}/`, payload);
    return res.data;
  },

  update: async (id: number, payload: AccountUpdate) => {
    const res = await api.put(`${API_BASE}/${id}`, payload);
    return res.data;
  },

  delete: async (id: number) => {
    const res = await api.delete(`${API_BASE}/${id}`);
    return res.data;
  },
};
