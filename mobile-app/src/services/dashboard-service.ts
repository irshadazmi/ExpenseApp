import api from '@/config/api';
import {
  DashboardSummaryResponse,
  DashboardCategoryResponse,
  DashboardAccountResponse,
  DashboardTransactionResponse
} from '@/types/dashboard';

const DASHBOARD_BASE = '/dashboard';

export const dashboardService = {

  /** Overall KPIs: total budget vs spend */
  getSummary: async (userId: number) => {
    const res = await api.get<DashboardSummaryResponse>(
      `${DASHBOARD_BASE}/summary`,
      {
        params: { user_id: userId },
      }
    );
    return res.data;
  },

  /** Category-wise breakdown + overspend */
  getCategories: async (userId: number) => {
    const res = await api.get<DashboardCategoryResponse[]>(
      `${DASHBOARD_BASE}/categories`,
      {
        params: { user_id: userId },
      }
    );
    return res.data;
  },

  /** Recent transactions feed */
  getRecentTransactions: async (
    userId: number,
    limit: number = 20
  ) => {
    const res = await api.get<DashboardTransactionResponse[]>(
      `${DASHBOARD_BASE}/recent`,
      {
        params: {
          user_id: userId,
          limit
        }
      }
    );

    return res.data;
  },

  /** Accounts overview */
  getAccounts: async (userId: number) => {
    const res = await api.get<DashboardAccountResponse[]>(
      `${DASHBOARD_BASE}/accounts`,
      {
        params: { user_id: userId },
      }
    );
    return res.data;
  },
};
