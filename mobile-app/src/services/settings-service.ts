import AsyncStorage from "@react-native-async-storage/async-storage";
import { AppSettings } from "@/types/settings";

const KEY = "APP_SETTINGS";

const DEFAULTS: AppSettings = {
  currency: "INR",
  dateFormat: "DD-MM-YYYY",
  dashboardPeriod: "Monthly",
  budgetAlerts: true,
  theme: "Light", // Add the missing theme property
};

export const settingsService = {
  async get(): Promise<AppSettings> {
    const raw = await AsyncStorage.getItem(KEY);
    return raw ? JSON.parse(raw) : DEFAULTS;
  },

  async save(settings: AppSettings) {
    await AsyncStorage.setItem(KEY, JSON.stringify(settings));
  },
};
