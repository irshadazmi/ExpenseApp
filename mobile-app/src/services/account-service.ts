// src/services/accountService.ts
import api from '@/config/api';
import { AccountCreate, AccountResponse, AccountUpdate } from '@/types/account';

const ACCOUNT_BASE = '/accounts';

export const accountService = {
  getByUser: async (userId: number) => {
    const res = await api.get<AccountResponse[]>(`${ACCOUNT_BASE}/`, {
      params: { user_id: userId },
    });
    console.log("getByUser", res.data);
    return res.data;
  },

  getAll: async () => {
    const res = await api.get<AccountResponse[]>(`${ACCOUNT_BASE}/`);
    return res.data;
  },

  getById: async (id: number) => {
    const res = await api.get<AccountResponse>(`${ACCOUNT_BASE}/${id}`);
    return res.data;
  },

  create: async (payload: AccountCreate) => {
    const res = await api.post(`${ACCOUNT_BASE}/`, payload);
    return res.data;
  },

  update: async (id: number, payload: AccountUpdate) => {
    const res = await api.put(`${ACCOUNT_BASE}/${id}`, payload);
    return res.data;
  },

  delete: async (id: number) => {
    const res = await api.delete(`${ACCOUNT_BASE}/${id}`);
    return res.data;
  },
};
