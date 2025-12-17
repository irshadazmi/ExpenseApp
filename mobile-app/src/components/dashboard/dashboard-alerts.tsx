// mobile-app/src/app/(dashboard)/dashboard-alerts.tsx
import React from "react";
import { View, Text } from "react-native";

import { useAppColors } from "@/hooks/use-app-colors";
import { AIInsight } from "@/types/ai";
import { useStyles } from "@/styles/styles";

interface DashboardAlertsProps {
  alerts: AIInsight[];
}

export const DashboardAlerts: React.FC<DashboardAlertsProps> = ({ alerts }) => {
  const COLORS = useAppColors();
  const styles = useStyles();

  const getSeverityColor = (severity: string) => {
    switch (severity?.toLowerCase()) {
      case "HIGH":
        return COLORS.danger;
      case "MEDIUM":
        return COLORS.warning;
      case "LOW":
      default:
        return COLORS.success;
    }
  };

  return (
    <View>
      {alerts.slice(0, 2).map((item, i) => (
        <View
          key={i}
          style={{
            backgroundColor: COLORS.surface,
            padding: 12,
            borderRadius: 12,
            borderLeftWidth: 5,
            borderLeftColor: COLORS.danger,
            marginBottom: 8,
          }}
        >
          <Text
            style={{
              fontSize: 14,
              fontWeight: "700",
              color: COLORS.text,
            }}
          >
            {item.title}
          </Text>

          <Text
            style={{
              marginTop: 4,
              fontSize: 13,
              color: COLORS.textSecondary,
              lineHeight: 18,
            }}
          >
            {item.message}
          </Text>

          <Text
            style={{
              marginTop: 6,
              fontSize: 11,
              fontWeight: "700",
              color: getSeverityColor(item.severity),
              textTransform: "uppercase",
            }}
          >
            {item.severity} severity
          </Text>
        </View>
      ))}
    </View>
  );
};

