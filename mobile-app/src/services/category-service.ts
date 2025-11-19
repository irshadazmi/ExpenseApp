// src/services/categoryService.ts
import api from '@/config/api';
import { CategoryResponse } from '@/types/category'; // create later if missing

const CATEGORY_BASE = '/categories';

export const categoryService = {
  getAll: async (skip = 0, limit = 10) => {
    const res = await api.get(`${CATEGORY_BASE}/`, {
      params: { skip, limit },
    });
    return res.data;
  },

  getById: async (id: number) => {
    const res = await api.get(`${CATEGORY_BASE}/${id}`);
    return res.data;
  },

  create: async (payload: CategoryResponse) => {
    const res = await api.post(`${CATEGORY_BASE}/`, payload);
    return res.data;
  },

  update: async (id: number, payload: CategoryResponse) => {
    const res = await api.put(`${CATEGORY_BASE}/${id}`, payload);
    return res.data;
  },

  delete: async (id: number) => {
    const res = await api.delete(`${CATEGORY_BASE}/${id}`);
    return res.data;
  },
};

