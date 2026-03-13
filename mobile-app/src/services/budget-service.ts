import api from "../config/api";
import { BudgetResponse } from "../types/budget";

export const budgetService = {
  getByUser: async (userId: number) => {
    const res = await api.get<BudgetResponse[]>("/budgets", {
      params: { user_id: userId },
    });
    return res.data;
  },
};