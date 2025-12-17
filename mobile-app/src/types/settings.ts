export interface AppSettings {
  currency: string;
  dateFormat: "DD-MM-YYYY" | "MM-DD-YYYY";
  dashboardPeriod: "Monthly" | "Quarterly" | "Yearly";
  budgetAlerts: boolean;

  // ✅ ADD
  theme: "Light" | "Dark" | "System";
}
