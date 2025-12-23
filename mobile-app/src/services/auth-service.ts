// src/services/auth-service.ts

import api from "@/config/api";
import {
  AuthUser,
  AuthToken,
  LoginResponse,
  RegisterRequest,
  RegisterResponse,
} from "@/types/auth";

/* ======================================================
   AUTH SERVICE
   Thin wrapper around FastAPI auth endpoints.
   Base URL is configured in src/config/api.ts (API_BASE_URL)
====================================================== */

class AuthService {

  async getById(user_id: number): Promise<AuthUser> {
    const res = await api.get<AuthUser>(`/auth/${user_id}`);
    return res.data;
  }

  async login(email: string, password: string): Promise<LoginResponse> {
    const res = await api.post<LoginResponse>("/auth/login", {
      email,
      password,
    });
    return res.data;
  }

  async register(payload: RegisterRequest): Promise<RegisterResponse> {
    const res = await api.post<RegisterResponse>("/auth/register", payload);
    console.log(res.data);
    return res.data;
  }

  async getCurrentUser(): Promise<AuthUser> {
    const res = await api.get<AuthUser>("/auth/me");
    return res.data;
  }

  async refreshToken(): Promise<LoginResponse> {
    const res = await api.post<LoginResponse>("/auth/refresh");
    return res.data;
  }
}

export const authService = new AuthService();
