import { TransactionResponse } from "../types/transaction";
import api from "../config/api";

export const transactionService = {
  getByUser: async (userId: number) => {
    const res = await api.get<TransactionResponse[]>("/transactions", {
      params: { user_id: userId },
    });
    return res.data;
  },

  getAll: async () => {
    const res = await api.get<TransactionResponse[]>("/transactions");
    return res.data;
  },
};