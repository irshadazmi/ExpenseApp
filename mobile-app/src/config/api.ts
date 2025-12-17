// src/config/api.ts
import axios, {
  InternalAxiosRequestConfig,
  AxiosError,
} from 'axios';
import Constants from 'expo-constants';
import AsyncStorage from '@react-native-async-storage/async-storage';

const API_BASE_URL =
  Constants.expoConfig?.extra?.API_BASE_URL || 'http://192.168.29.62/api';

const api = axios.create({
  baseURL: API_BASE_URL,
});

// 🔐 Request interceptor – attach token if present
api.interceptors.request.use(
  async (config: InternalAxiosRequestConfig) => {
    try {
      const token = await AsyncStorage.getItem('access_token');

      if (token) {
        // If headers is AxiosHeaders instance (Axios v1+)
        if (config.headers && typeof config.headers.set === 'function') {
          config.headers.set('Authorization', `Bearer ${token}`);
        } else {
          // Fallback for plain object headers
          config.headers = {
            ...(config.headers || {}),
            Authorization: `Bearer ${token}`,
          } as any;
        }
      }
    } catch (e) {
      console.warn('Failed to read token from storage:', e);
    }

    return config;
  },
  (error: AxiosError) => {
    return Promise.reject(error);
  }
);

// 🔁 Response interceptor – logging (optional)
api.interceptors.response.use(
  (response) => response,
  (error: AxiosError) => {
    if (error.response) {
      console.log(
        'API error:',
        error.response.status,
        error.config?.url,
        JSON.stringify(error.response.data, null, 2)
      );
    } else {
      console.log('API error (no response):', error.message);
    }
    return Promise.reject(error);
  }
);

export default api;
