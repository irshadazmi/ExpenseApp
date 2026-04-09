// mobile-app/src/app/(dashboard)/components/usage-bar.tsx
import React from "react";
import { View, Text } from "react-native";

import { useStyles } from "@/styles/styles";
import { useAppColors } from "@/hooks/use-app-colors";
import { DashboardSummary } from "@/types/dashboard";

const CHART_COLORS = {
  amber: "#FFCA28",
};

interface UsageBarProps {
  summary: DashboardSummary;
}

export const UsageBar: React.FC<UsageBarProps> = ({ summary }) => {
  const styles = useStyles();
  const COLORS = useAppColors();

  const usage = summary.totals.usage_percent || 0;
  const capped = Math.min(usage, 200);

  let color = COLORS.primary;
  if (usage > 100) color = COLORS.danger;
  else if (usage > 80) color = CHART_COLORS.amber;

  return (
    <View style={styles.dashboardUsageBox}>
      <View
        style={{
          flexDirection: "row",
          justifyContent: "space-between",
        }}
      >
        <Text style={styles.label}>Usage</Text>
        <Text style={styles.label}>{usage.toFixed(1)}%</Text>
      </View>

      <View
        style={{
          width: `${capped}%`,
          height: 8,
          backgroundColor: color,
          borderRadius: 4,
          marginTop: 8,
        }}
      />

      {summary.totals.projected_usage && (
        <View
          style={{
            position: "absolute",
            left: `${summary.totals.projected_usage}%`,
            top: 24,
            height: 16,
            width: 2,
            backgroundColor: COLORS.danger,
          }}
        />
      )}
    </View>
  );
};
