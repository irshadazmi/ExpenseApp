// src/config/api.ts

import axios, {
  InternalAxiosRequestConfig,
  AxiosError,
  AxiosInstance,
} from "axios";
import Constants from "expo-constants";
import AsyncStorage from "@react-native-async-storage/async-storage";

/* ======================================================
   BASE URL
   Reads from app config, falls back to local dev API.
====================================================== */

const API_BASE_URL: string =
  (Constants.expoConfig?.extra as any)?.API_BASE_URL ??
  "http://192.168.29.62/api";

/* ======================================================
   AXIOS INSTANCE
====================================================== */

const api: AxiosInstance = axios.create({
  baseURL: API_BASE_URL,
  timeout: 15000, // 15s – avoid hanging requests
});

/* ======================================================
   REQUEST INTERCEPTOR
   Attach Bearer token from AsyncStorage if present.
   Storage key matches auth-context.
====================================================== */

const ACCESS_TOKEN_KEY = "@auth:token";

api.interceptors.request.use(
  async (config: InternalAxiosRequestConfig) => {
    try {
      const raw = await AsyncStorage.getItem(ACCESS_TOKEN_KEY);

      if (raw) {
        const parsed = JSON.parse(raw) as { access_token?: string } | null;
        const token = parsed?.access_token;

        if (token) {
          // Axios v1 headers can be AxiosHeaders or plain object
          if (config.headers && typeof (config.headers as any).set === "function") {
            (config.headers as any).set("Authorization", `Bearer ${token}`);
          } else {
            config.headers = {
              ...(config.headers || {}),
              Authorization: `Bearer ${token}`,
            } as any;
          }
        }
      }
    } catch (e) {
      console.warn("[API] Failed to read token from storage:", e);
    }

    return config;
  },
  (error: AxiosError) => Promise.reject(error)
);

/* ======================================================
   RESPONSE INTERCEPTOR
   Centralized logging; place to add 401 handling later.
====================================================== */

api.interceptors.response.use(
  (response) => response,
  (error: AxiosError) => {
    if (error.response) {
      console.log(
        "[API] Error:",
        error.response.status,
        error.config?.method?.toUpperCase(),
        error.config?.url,
        JSON.stringify(error.response.data, null, 2)
      );
    } else {
      console.log("[API] Error (no response):", error.message);
    }

    return Promise.reject(error);
  }
);

export default api;
