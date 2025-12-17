// mobile-app/src/services/dashboard-service.ts
import api from "@/config/api";
import { CategoryReportItem, DashboardSummary, RecentTransaction } from "@/types/dashboard";

const API_BASE = "/dashboard";

export const dashboardService = {
  getSummary: async (user_id: number, year?: number, month?: number) =>
    (
      await api.get<DashboardSummary>(
        `${API_BASE}/summary`,
        { params: { user_id, year, month } }
      )
    ).data,

  getCategories: async (user_id: number, year?: number, month?: number) =>
    (
      await api.get<CategoryReportItem[]>(
        `${API_BASE}/categories`,
        { params: { user_id, year, month } }
      )
    ).data,

  getRecent: async (user_id: number, year?: number, month?: number) =>
    (
      await api.get<RecentTransaction[]>(
        `${API_BASE}/recent`,
        { params: { user_id, year, month } }
      )
    ).data,

  getAccounts: async (user_id: number) =>
    (
      await api.get(
        `${API_BASE}/accounts`,
        { params: { user_id } }
      )
    ).data,
};
