// mobile-app/src/app/components/dashboard/KPIs.tsx
import React from "react";
import { View, Text } from "react-native";

import { useStyles } from "@/styles/styles";
import { useAppColors } from "@/hooks/use-app-colors";
import { DashboardSummary } from "@/types/dashboard";

interface KPIsProps {
  summary: DashboardSummary;
}

export const KPIs: React.FC<KPIsProps> = ({ summary }) => {
  const styles = useStyles();
  const COLORS = useAppColors();

  return (
    <View style={styles.dashboardCardRow}>
      <View style={styles.card}>
        <Text style={styles.label}>TOTAL BUDGET</Text>
        <Text style={styles.title}>
          ₹{summary.totals.budget.toLocaleString("en-IN")}
        </Text>
        <Text style={{ color: COLORS.green }}>
          Income: ₹{summary.totals.earning.toLocaleString("en-IN")}
        </Text>
      </View>

      <View style={styles.card}>
        <Text style={styles.label}>TOTAL SPENT</Text>
        <Text style={[styles.title, { color: COLORS.danger }]}>
          ₹{summary.totals.spent.toLocaleString("en-IN")}
        </Text>
        <Text style={{ color: COLORS.green }}>
          Remaining: ₹{summary.totals.remaining.toLocaleString("en-IN")}
        </Text>
      </View>
    </View>
  );
};
