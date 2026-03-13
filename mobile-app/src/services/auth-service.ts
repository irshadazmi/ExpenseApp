// src/services/auth-service.ts
import api from "../config/api";

let currentUser: any = null;

export const authService = {
  login: async (email: string, password: string) => {
    const res = await api.post("/auth/login", {
      email,
      password
    });

    currentUser = res.data.user;
    return res.data;
  },

  getCurrentUser: async () => {
    if (currentUser) return currentUser;
    const res = await api.get("/auth/me");
    currentUser = res.data;
    return currentUser;
  },

  logout: () => {
    currentUser = null;
  }
};