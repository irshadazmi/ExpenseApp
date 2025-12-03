import React, { useCallback, useEffect, useState } from "react";
import { FlatList, View, Text, Dimensions } from "react-native";
import { PieChart } from "react-native-chart-kit";

import { useAuth } from "@/contexts/auth-context";
import {
  dashboardService,
  DashboardSummary,
  CategoryReportItem,
  RecentTransaction,
} from "@/services/dashboard-service";

import styles from "@/styles/styles";
import { COLORS } from "@/constants/COLORS";

const screenWidth = Dimensions.get("window").width;

const COLORS_SCALE = [
  "#7C4DFF",
  "#26A69A",
  "#FF7043",
  "#42A5F5",
  "#AB47BC",
  "#FFCA28",
  "#EC407A",
  "#66BB6A",
  "#29B6F6",
  "#FF8A65",
];

export default function Dashboard() {
  const { user } = useAuth();

  const [summary, setSummary] = useState<DashboardSummary | null>(null);
  const [categories, setCategories] = useState<CategoryReportItem[]>([]);
  const [recent, setRecent] = useState<RecentTransaction[]>([]);
  const [loading, setLoading] = useState(false);

  // ------------------------------------------------

  const loadData = useCallback(async () => {
    if (!user) return;

    setLoading(true);
    try {
      const [s, c, r] = await Promise.all([
        dashboardService.getSummary(user.id),
        dashboardService.getCategories(user.id),
        dashboardService.getRecent(user.id),
      ]);

      setSummary(s);
      setCategories(c);
      setRecent(r);
    } catch (err) {
      console.log("Dashboard load error", err);
    } finally {
      setLoading(false);
    }
  }, [user]);

  useEffect(() => {
    loadData();
  }, [loadData]);

  if (!summary) return null;

  // ------------------------------------------------

  const usage = Math.min(summary.totals.usage_percent || 0, 200);

  const pieData = categories
    .filter((c) => c.spent > 0)
    .map((c, i) => ({
      name: c.category_name,
      amount: c.spent,
      color: COLORS_SCALE[i % COLORS_SCALE.length],
      legendFontColor: COLORS.text,
      legendFontSize: 12,
    }));

  // ------------------------------------------------

  const renderHeader = () => {
    return (
      <View style={styles.dashboardHeaderContainer}>
        {/* KPI ROW */}
        <View style={styles.dashboardCardRow}>
          <View style={[styles.card, { flex: 1, marginRight: 8 }]}>
            <Text style={styles.label}>TOTAL BUDGET</Text>
            <Text style={styles.title}>
              ₹{summary.totals.budget.toLocaleString("en-IN")}
            </Text>
          </View>

          <View style={[styles.card, { flex: 1, marginLeft: 8 }]}>
            <Text style={styles.label}>SPENT</Text>
            <Text style={[styles.title, { color: COLORS.red }]}>
              ₹{summary.totals.spent.toLocaleString("en-IN")}
            </Text>
            <Text style={styles.description}>
              Remaining ₹{summary.totals.remaining.toLocaleString("en-IN")}
            </Text>
          </View>
        </View>

        {/* USAGE BAR */}
        <View style={styles.dashboardUsageBox}>
          <Text style={styles.label}>
            Usage {summary.totals.usage_percent.toFixed(1)}%
          </Text>

          <View style={styles.barBg}>
            <View style={[styles.barFill, { width: `${usage}%` }]} />
          </View>
        </View>

        {/* PIE CHART */}
        {pieData.length > 0 && (
          <View style={styles.dashboardChartBox}>
            <Text style={styles.dashboardChartTitle}>
              Expenses by Category
            </Text>

            <PieChart
              data={pieData}
              width={screenWidth - 32}
              height={240}
              accessor="amount"
              backgroundColor="transparent"
              paddingLeft="12"
              chartConfig={{
                backgroundColor: "#fff",
                backgroundGradientFrom: "#fff",
                backgroundGradientTo: "#fff",
                color: () => "#000",
              }}
              absolute
            />
          </View>
        )}

        {/* CATEGORY STATUS */}
        <View style={styles.dashboardSection}>
          <Text style={styles.dashboardChartTitle}>Spending vs Budget</Text>

          {categories.map((c) => {
            const pct = c.usage_percent || 0;

            return (
              <View
                key={c.category_id}
                style={styles.dashboardCategoryRow}
              >
                <Text style={styles.dashboardCategoryTitle}>
                  {c.category_name}
                </Text>

                <View style={styles.barBgSmall}>
                  <View
                    style={[
                      styles.barFill,
                      {
                        width: `${Math.min(pct, 200)}%`,
                        backgroundColor:
                          pct > 100 ? COLORS.red : COLORS.primary,
                      },
                    ]}
                  />
                </View>

                <Text style={styles.description}>
                  ₹{c.spent.toLocaleString("en-IN")} / ₹
                  {c.budget.toLocaleString("en-IN")} ({pct.toFixed(0)}%)
                </Text>
              </View>
            );
          })}
        </View>

        <Text style={styles.dashboardChartTitle}>
          Recent Transactions
        </Text>
      </View>
    );
  };

  // ------------------------------------------------

  const renderItem = ({ item }: { item: RecentTransaction }) => (
    <View style={styles.txnRow}>
      <View>
        <Text style={styles.txnTitle}>{item.description}</Text>
        <Text style={styles.description}>
          {item.category} ·{" "}
          {new Date(item.transaction_date).toDateString()}
        </Text>
      </View>

      <Text
        style={[
          styles.txnAmt,
          { color: item.type === "Income" ? COLORS.green : COLORS.red },
        ]}
      >
        {item.type === "Income" ? "+" : "-"}₹
        {item.amount.toLocaleString("en-IN")}
      </Text>
    </View>
  );

  // ------------------------------------------------

  return (
    <FlatList
      data={recent}
      renderItem={renderItem}
      keyExtractor={(item) => String(item.id)}
      ListHeaderComponent={renderHeader}
      contentContainerStyle={{ paddingBottom: 40 }}
      refreshing={loading}
      onRefresh={loadData}
    />
  );
}
