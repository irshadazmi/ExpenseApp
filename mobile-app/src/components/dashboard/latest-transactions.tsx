// mobile-app/src/app/(dashboard)/components/latest-transactions.tsx
import React from "react";
import { View, Text } from "react-native";

import { useStyles } from "@/styles/styles";
import { useAppColors } from "@/hooks/use-app-colors";
import { RecentTransaction } from "@/types/dashboard";

interface LatestTransactionsProps {
  transactions: RecentTransaction[];
}

export const LatestTransactions: React.FC<LatestTransactionsProps> = ({
  transactions,
}) => {
  const styles = useStyles();
  const COLORS = useAppColors();

  return (
    <View style={styles.dashboardSection}>
      <Text style={styles.dashboardChartTitle}>Latest Transactions: {transactions.length}</Text>
      {transactions.map((t) => (
        <View key={t.id} style={styles.card}>
          <View style={styles.metaRow}>
            <Text style={styles.cardTitle}>{t.description}</Text>
            <Text
              style={[
                styles.txnAmt,
                {
                  color: t.type === "Income" ? COLORS.green : COLORS.red,
                },
              ]}
            >
              {t.type === "Income" ? "+" : "-"}₹{t.amount.toLocaleString("en-IN")}
            </Text>
          </View>

          <View style={styles.metaRow}>
            <Text style={styles.metaText}>{t.category}</Text>
            <Text style={styles.metaText}>
              {new Date(t.transaction_date).toDateString()}
            </Text>
          </View>
        </View>
      ))}
    </View>
  );
};
