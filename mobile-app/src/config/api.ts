// src/config/api.ts
import axios from 'axios';
import Constants from "expo-constants";

const API_BASE_URL = Constants.expoConfig?.extra?.API_BASE_URL || 'http://192.168.29.62/api';

const api = axios.create({
  baseURL: API_BASE_URL,
});

export default api;
