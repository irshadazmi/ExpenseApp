// mobile-app/src/services/dashboard-service.ts
import api from "@/config/api";

export type RiskLevel =
  | "under_budget"
  | "on_track"
  | "over_budget";

export type DashboardSummary = {
  totals: {
    budget: number;
    spent: number;
    earning: number;
    remaining: number;
    usage_percent: number;
  };
  period: {
    days_elapsed: number;
    days_in_month: number;
  };
  burn_rate: {
    daily_spend: number;
    daily_budget: number;
    risk: RiskLevel;
  };
};

export type CategoryReportItem = {
  category_id: number;
  category_name: string;
  short_name?: string;
  budget: number;
  spent: number;
  usage_percent: number | null;
};

export type RecentTransaction = {
  id: number;
  description: string;
  amount: number;
  transaction_date: string;
  category: string;
  type: "Expense" | "Income";
};

const BASE = "/dashboard";

export const dashboardService = {
  getSummary: async (user_id: number, year?: number, month?: number) =>
    (
      await api.get<DashboardSummary>(
        `${BASE}/summary`,
        { params: { user_id, year, month } }
      )
    ).data,

  getCategories: async (user_id: number, year?: number, month?: number) =>
    (
      await api.get<CategoryReportItem[]>(
        `${BASE}/categories`,
        { params: { user_id, year, month } }
      )
    ).data,

  getRecent: async (user_id: number, year?: number, month?: number) =>
    (
      await api.get<RecentTransaction[]>(
        `${BASE}/recent`,
        { params: { user_id, year, month } }
      )
    ).data,

  getAccounts: async (user_id: number) =>
    (
      await api.get(
        `${BASE}/accounts`,
        { params: { user_id } }
      )
    ).data,
};

