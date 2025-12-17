// src/contexts/AuthContext.tsx
import { createContext, ReactNode, useContext, useState, useEffect } from "react";
import AsyncStorage from "@react-native-async-storage/async-storage";
import { AuthRegisterSchema, AuthResponse, UserResponse } from "../types/auth";
import Constants from "expo-constants";

const API_BASE_URL =
  Constants.expoConfig?.extra?.API_BASE_URL || "http://192.168.29.62/api";

const TOKEN_EXPIRY_MINUTES: number =
  (Constants.expoConfig?.extra?.TOKEN_EXPIRY_MINUTES as number) || 60;

type AuthContextType = {
  user: AuthResponse["user"] | null;
  token: AuthResponse["token"] | null;
  loading: boolean;
  // login: (payload: { email: string; password: string }) => Promise<void>;
  login: (payload: { email: string; password: string }) => Promise<AuthResponse>;
  register: (payload: { userData: AuthRegisterSchema }) => Promise<void>;
  logout: () => void;
};

const AuthContext = createContext<AuthContextType | undefined>(undefined);

export const AuthProvider = ({ children }: { children: ReactNode }) => {
  const [user, setUser] = useState<AuthResponse["user"] | null>(null);
  const [token, setToken] = useState<AuthResponse["token"] | null>(null);
  const [loading, setLoading] = useState(true);

  const setSession = async (auth: AuthResponse) => {
    setUser(auth.user);
    setToken(auth.token);

    // Store token
    await AsyncStorage.setItem("access_token", auth.token.access_token);

    // Compute local expiry timestamp (in ms)
    const expiresAt =
      Date.now() + TOKEN_EXPIRY_MINUTES * 60 * 1000;
    await AsyncStorage.setItem(
      "access_token_expires_at",
      expiresAt.toString()
    );
  };

  const clearSession = async () => {
    setUser(null);
    setToken(null);
    await AsyncStorage.removeItem("access_token");
    await AsyncStorage.removeItem("access_token_expires_at");
  };

  useEffect(() => {
    const restoreSession = async () => {
      try {
        const storedToken = await AsyncStorage.getItem("access_token");
        const storedExpiresAt = await AsyncStorage.getItem(
          "access_token_expires_at"
        );

        // No token stored → not logged in
        if (!storedToken) {
          setLoading(false);
          return;
        }

        // Check local expiry if present
        if (storedExpiresAt) {
          const expiresAtNum = Number(storedExpiresAt);
          if (!Number.isNaN(expiresAtNum) && Date.now() > expiresAtNum) {
            console.log("Token expired locally, clearing session");
            await clearSession();
            setLoading(false);
            return;
          }
        }

        const url = `${API_BASE_URL}/auth/me`;

        const res = await fetch(url, {
          headers: { Authorization: `Bearer ${storedToken}` },
        });

        if (!res.ok) {
          const txt = await res.text().catch(() => "");
          console.error("auth/me error body:", txt);
          throw new Error("Session expired");
        }

        const data: AuthResponse = await res.json();

        setUser(data.user);
        setToken({ access_token: storedToken, token_type: "Bearer" });
      } catch (e) {
        console.error("restoreSession error:", e);
        await clearSession();
      } finally {
        setLoading(false);
      }
    };

    restoreSession();
  }, []);

  const login = async (payload: { email: string; password: string }) => {
    setLoading(true);
    try {
      const url = `${API_BASE_URL}/auth/login`;

      const res = await fetch(url, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(payload),
      });

      if (!res.ok) {
        const txt = await res.text().catch(() => "");
        console.error("auth/login error body:", txt);
        throw new Error("Login failed");
      }

      const data: AuthResponse = await res.json();

      await setSession(data);
      return data;
    } catch (err) {
      console.error("Login error:", err);
      throw err;
    } finally {
      setLoading(false);
    }
  };

  const register = async ({ userData }: { userData: AuthRegisterSchema }) => {
    setLoading(true);
    try {
      const url = `${API_BASE_URL}/auth/register`;

      const res = await fetch(url, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(userData),
      });

      if (!res.ok) {
        const txt = await res.text().catch(() => "");
        console.error("auth/register error body:", txt);
        throw new Error("Register failed");
      }

      const data: AuthResponse = await res.json();

      await setSession(data);
    } catch (err) {
      console.error("Register error:", err);
      throw err;
    } finally {
      setLoading(false);
    }
  };

  const logout = async () => {
    await clearSession();
  };

  return (
    <AuthContext.Provider
      value={{ user, token, loading, login, register, logout }}
    >
      {children}
    </AuthContext.Provider>
  );
};

export const useAuth = () => {
  const context = useContext(AuthContext);
  if (!context) throw new Error("useAuth must be used within AuthProvider");
  return context;
};
