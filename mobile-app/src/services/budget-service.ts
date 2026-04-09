// src/services/budgetService.ts
import api from "@/config/api";
import { BudgetResponse, SaveAllBudgetsPayload } from "@/types/budget";

const API_BASE = "/budgets";

export const budgetService = {
  getByUser: async (userId: number) => {
    const res = await api.get<BudgetResponse[]>(API_BASE, {
      params: { user_id: userId },
    });
    return res.data;
  },

  createAllBudgets: async (userId: number) => {
    const res = await api.post(
      "/budgets/create-all-budgets",
      null,
      { params: { user_id: userId } }
    );
    return res.data;
  },

  saveAllBudgets: async (payload: SaveAllBudgetsPayload) => {
    const res = await api.post<BudgetResponse[]>(
      `${API_BASE}/save-all-budgets`,
      payload
    );
    return res.data;
  },
};
