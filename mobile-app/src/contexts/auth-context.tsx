// mobile-app/src/contexts/AuthContext.tsx
import { createContext, ReactNode, useContext, useState, useEffect } from "react";
import AsyncStorage from "@react-native-async-storage/async-storage";
import { AuthRegisterSchema, AuthResponse, Token } from "../types/auth";
import Constants from "expo-constants";

const API_BASE_URL =
  Constants.expoConfig?.extra?.API_BASE_URL || "http://192.168.29.62/api";

console.log("AuthContext API_BASE_URL:", API_BASE_URL);

type AuthContextType = {
  user: AuthResponse["user"] | null;
  token: Token | null;
  loading: boolean;
  login: (payload: { email: string; password: string }) => Promise<void>;
  register: (payload: { userData: AuthRegisterSchema }) => Promise<void>;
  logout: () => void;
};

const ACCESS_TOKEN_KEY = "access_token";
const TOKEN_EXPIRES_AT_KEY = "token_expires_at";

const AuthContext = createContext<AuthContextType | undefined>(undefined);

export const AuthProvider = ({ children }: { children: ReactNode }) => {
  const [user, setUser] = useState<AuthResponse["user"] | null>(null);
  const [token, setToken] = useState<Token | null>(null);
  const [loading, setLoading] = useState(true);

  /** Check if token is expired based on ISO `expires_at` string */
  const isTokenExpired = (expiresAt?: string | null) => {
    if (!expiresAt) return false; // no expiry info => treat as non-expiring
    const now = Date.now();
    const exp = new Date(expiresAt).getTime();
    return Number.isFinite(exp) && exp <= now;
  };

  /** Set session after successful login/register */
  const setSession = async (auth: AuthResponse) => {
    const serverToken = auth.token;

    // derive final expires_at
    let expiresAt: string | undefined = serverToken.expires_at;

    if (!expiresAt && serverToken.expires_in) {
      // compute expiry based on "expires_in" seconds from now
      expiresAt = new Date(
        Date.now() + serverToken.expires_in * 1000
      ).toISOString();
    }

    const finalToken: Token = {
      access_token: serverToken.access_token,
      token_type: serverToken.token_type,
      expires_at: expiresAt,
      expires_in: serverToken.expires_in,
    };

    setUser(auth.user);
    setToken(finalToken);

    await AsyncStorage.setItem(ACCESS_TOKEN_KEY, finalToken.access_token);
    if (finalToken.expires_at) {
      await AsyncStorage.setItem(TOKEN_EXPIRES_AT_KEY, finalToken.expires_at);
    } else {
      await AsyncStorage.removeItem(TOKEN_EXPIRES_AT_KEY);
    }
  };

  const clearSession = async () => {
    setUser(null);
    setToken(null);
    await AsyncStorage.multiRemove([ACCESS_TOKEN_KEY, TOKEN_EXPIRES_AT_KEY]);
  };

  /** Restore session on app load */
  useEffect(() => {
    const restoreSession = async () => {
      try {
        const [storedToken, storedExpiresAt] = await AsyncStorage.multiGet([
          ACCESS_TOKEN_KEY,
          TOKEN_EXPIRES_AT_KEY,
        ]).then((entries) => entries.map((e) => e[1]));

        console.log("restoreSession: storedToken =", storedToken);
        console.log("restoreSession: storedExpiresAt =", storedExpiresAt);

        if (!storedToken) {
          setLoading(false);
          return;
        }

        // Check expiry BEFORE hitting backend
        if (isTokenExpired(storedExpiresAt)) {
          console.log("Token expired on restore, clearing session");
          await clearSession();
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
        setToken({
          access_token: storedToken,
          token_type: "Bearer",
          expires_at: storedExpiresAt || undefined,
        });
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
