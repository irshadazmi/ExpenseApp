import api from '@/config/api';

export type DashboardSummary = {
  totals: {
    budget: number;
    spent: number;
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
    risk: 'under_budget' | 'on_track' | 'over_budget';
  };
};

export type CategoryReportItem = {
  category_id: number;
  category_name: string;
  budget: number;
  spent: number;
  usage_percent: number;
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
  getSummary: async (user_id:number) =>
    (await api.get<DashboardSummary>(`${BASE}/summary?user_id=${user_id}`)).data,

  getCategories: async (user_id:number) =>
    (await api.get<CategoryReportItem[]>(`${BASE}/categories?user_id=${user_id}`)).data,

  getRecent: async (user_id:number) =>
    (await api.get<RecentTransaction[]>(`${BASE}/recent?user_id=${user_id}`)).data,

  getAccounts: async (user_id:number) =>
    (await api.get(`${BASE}/accounts?user_id=${user_id}`)).data
};
