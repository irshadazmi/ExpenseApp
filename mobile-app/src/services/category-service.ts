// src/services/categoryService.ts
import api from '@/config/api';
import { CategoryCreate, CategoryResponse, CategoryUpdate } from '@/types/category'; // create later if missing

const API_BASE = '/categories';

export const categoryService = {
  getAll: async () => {
    const res = await api.get<CategoryResponse[]>(`${API_BASE}/`);
    return res.data;
  },

  getById: async (id: number) => {
    const res = await api.get<CategoryResponse>(`${API_BASE}/${id}`);
    return res.data;
  },

  create: async (payload: CategoryCreate) => {
    const res = await api.post(`${API_BASE}/`, payload);
    return res.data;
  },

  update: async (id: number, payload: CategoryUpdate) => {
    const res = await api.put(`${API_BASE}/${id}`, payload);
    return res.data;
  },

  delete: async (id: number) => {
    const res = await api.delete(`${API_BASE}/${id}`);
    return res.data;
  },
};

