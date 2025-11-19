// mobile-app/src/contexts/AuthContext.tsx
import { createContext, ReactNode, useContext, useState, useEffect } from "react";
import AsyncStorage from "@react-native-async-storage/async-storage";
import { AuthRegisterSchema, AuthResponse } from "../types/auth";
import Constants from "expo-constants";

const API_BASE_URL =
  Constants.expoConfig?.extra?.API_BASE_URL || "http://192.168.29.62/api";

console.log("AuthContext API_BASE_URL:", API_BASE_URL);

type AuthContextType = {
  user: AuthResponse["user"] | null;
  token: AuthResponse["token"] | null;
  loading: boolean;
  login: (payload: { email: string; password: string }) => Promise<void>;
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
    await AsyncStorage.setItem("access_token", auth.token.access_token);
  };

  const clearSession = async () => {
    setUser(null);
    setToken(null);
    await AsyncStorage.removeItem("access_token");
  };

  useEffect(() => {
    const restoreSession = async () => {
      try {
        const storedToken = await AsyncStorage.getItem("access_token");
        console.log("restoreSession: storedToken =", storedToken);

        if (!storedToken) {
          setLoading(false);
          return;
        }

        const url = `${API_BASE_URL}/auth/me`;
        console.log("Calling:", url);

        const res = await fetch(url, {
          headers: { Authorization: `Bearer ${storedToken}` },
        });

        console.log("auth/me status:", res.status);

        if (!res.ok) {
          const txt = await res.text().catch(() => "");
          console.error("auth/me error body:", txt);
          throw new Error("Session expired");
        }

        const data: AuthResponse = await res.json();
        console.log("auth/me success:", data);

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
      console.log("Login using base URL:", API_BASE_URL);
      console.log("Login URL:", url);
      console.log("Login payload:", { email: payload.email });

      const res = await fetch(url, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(payload),
      });

      console.log("auth/login status:", res.status);

      if (!res.ok) {
        const txt = await res.text().catch(() => "");
        console.error("auth/login error body:", txt);
        throw new Error("Login failed");
      }

      const data: AuthResponse = await res.json();
      console.log("auth/login success:", data);

      await setSession(data);
    } catch (err) {
      console.error("Login error:", err);
      // Optional: show a toast/alert at UI level using the screen
      throw err;
    } finally {
      setLoading(false);
    }
  };

  const register = async ({ userData }: { userData: AuthRegisterSchema }) => {
    setLoading(true);
    try {
      const url = `${API_BASE_URL}/auth/register`;
      console.log("Register URL:", url);

      const res = await fetch(url, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(userData),
      });

      console.log("auth/register status:", res.status);

      if (!res.ok) {
        const txt = await res.text().catch(() => "");
        console.error("auth/register error body:", txt);
        throw new Error("Register failed");
      }

      const data: AuthResponse = await res.json();
      console.log("auth/register success:", data);

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
    <AuthContext.Provider value={{ user, token, loading, login, register, logout }}>
      {children}
    </AuthContext.Provider>
  );
};

export const useAuth = () => {
  const context = useContext(AuthContext);
  if (!context) throw new Error("useAuth must be used within AuthProvider");
  return context;
};