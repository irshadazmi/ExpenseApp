// src/app/(tabs)/dashboard.tsx

import React, { useCallback, useEffect, useState } from "react";
import {
  View,
  Text,
  FlatList,
  Dimensions,
  ActivityIndicator,
} from "react-native";

import { BarChart, PieChart } from "react-native-chart-kit";

import styles from "@/styles/styles";
import { COLORS } from "@/constants/COLORS";
import { useAuth } from "@/contexts/auth-context";

import {
  dashboardService,
  DashboardSummary,
  CategoryReportItem,
  RecentTransaction,
} from "@/services/dashboard-service";

/* ================================================= */

const screenWidth = Dimensions.get("window").width;

/* ================================================= */
/* CHART CONFIG */
/* ================================================= */

const chartConfig = {
  backgroundGradientFrom: COLORS.white,
  backgroundGradientTo: COLORS.white,

  // ✅ REQUIRED to avoid crash
  color: (opacity = 1) =>
    `rgba(0, 0, 0, ${opacity})`,

  labelColor: (opacity = 1) =>
    `rgba(0, 0, 0, ${opacity})`,

  propsForBackgroundLines: {
    stroke: "#DDD",
    strokeDasharray: "3 3",
  },

  barPercentage: 0.7,
};

/* ================================================= */

const PIE_COLORS = [
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

const BAR_COLORS = {
  spent: COLORS.danger,
  budget: COLORS.primary,
};

/* ================================================= */

const Dashboard = () => {
  const { user } = useAuth();

  const [summary, setSummary] =
    useState<DashboardSummary | null>(null);

  const [categories, setCategories] =
    useState<CategoryReportItem[]>([]);

  const [recent, setRecent] =
    useState<RecentTransaction[]>([]);

  const [loading, setLoading] =
    useState(true);

  /* ================================================= */

  const loadDashboard = useCallback(async () => {
    if (!user) return;

    try {
      setLoading(true);

      const [s, c, r] = await Promise.all([
        dashboardService.getSummary(user.id),
        dashboardService.getCategories(user.id),
        dashboardService.getRecent(user.id),
      ]);

      setSummary(s);
      setCategories(c);
      setRecent(r);
    } catch (err) {
      console.log("Dashboard load error:", err);
    } finally {
      setLoading(false);
    }
  }, [user]);

  useEffect(() => {
    loadDashboard();
  }, [loadDashboard]);

  /* ================================================= */

  if (loading || !summary) {
    return (
      <View style={[styles.container, { justifyContent: "center" }]}>
        <ActivityIndicator size="large" color={COLORS.primary} />
      </View>
    );
  }

  const usage =
    Math.min(summary.totals.usage_percent || 0, 200);

  /* ================================================= */
  /* PIE DATA */
  /* ================================================= */

  const pieData = categories
    .filter((c) => c.spent > 0)
    .map((c, i) => ({
      name: c.category_name,
      population: c.spent,
      color: PIE_COLORS[i % PIE_COLORS.length],
      legendFontColor: COLORS.text,
      legendFontSize: 12,
    }));

  /* ================================================= */
  /* BAR DATA */
  /* ================================================= */

  const barData = {
    labels: categories.map((c) => c.category_name),
    datasets: [
      {
        data: categories.map((c) => c.spent),
        colors: categories.map(() => () => BAR_COLORS.spent),
      },
      {
        data: categories.map((c) => c.budget),
        colors: categories.map(() => () => BAR_COLORS.budget),
      },
    ],
    legend: ["Spent", "Budget"],
  };

  /* ================================================= */

  const renderHeader = () => (
    <View style={styles.dashboardHeaderContainer}>

      {/* KPI CARDS */}
      <View style={styles.dashboardCardRow}>
        <View style={styles.card}>
          <Text style={styles.label}>TOTAL BUDGET</Text>
          <Text style={styles.title}>
            ₹{summary.totals.budget.toLocaleString("en-IN")}
          </Text>
        </View>

        <View style={styles.card}>
          <Text style={styles.label}>SPENT</Text>
          <Text style={[styles.title, { color: COLORS.danger }]}>
            ₹{summary.totals.spent.toLocaleString("en-IN")}
          </Text>

          <Text style={styles.text}>
            Remaining ₹{summary.totals.remaining.toLocaleString("en-IN")}
          </Text>
        </View>
      </View>

      {/* USAGE BAR */}
      <View style={styles.dashboardUsageBox}>
        <Text style={styles.label}>
          Usage {usage.toFixed(1)}%
        </Text>

        <View style={styles.barBg}>
          <View
            style={[
              styles.barFill,
              {
                width: `${usage}%`,
                backgroundColor:
                  usage > 100
                    ? COLORS.danger
                    : COLORS.primary,
              },
            ]}
          />
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
            accessor="population"
            backgroundColor="transparent"

            yAxisLabel=""
            yAxisSuffix=""

            chartConfig={chartConfig}
            paddingLeft="16"
            hasLegend
          />
        </View>
      )}

      {/* BAR CHART */}
      <View style={styles.dashboardChartBox}>
        <Text style={styles.dashboardChartTitle}>
          Spending vs Budget
        </Text>

        <BarChart
          data={barData}
          width={screenWidth - 32}
          height={300}

          fromZero
          flatColor
          withCustomBarColorFromData
          showBarTops={false}

          // ✅ FIXES LABEL OVERLAP
          verticalLabelRotation={70}
          horizontalLabelRotation={0}
          xLabelsOffset={10}

          // Required props
          yAxisLabel=""
          yAxisSuffix=""

          chartConfig={chartConfig}
        />
      </View>

      <Text style={styles.dashboardChartTitle}>
        Recent Transactions
      </Text>

    </View>
  );

  /* ================================================= */

  const renderItem = ({
    item,
  }: {
    item: RecentTransaction;
  }) => (
    <View style={styles.txnRow}>
      <View>
        <Text style={styles.txnTitle}>{item.description}</Text>
        <Text style={styles.text}>
          {item.category} ·{" "}
          {new Date(item.transaction_date).toDateString()}
        </Text>
      </View>

      <Text
        style={[
          styles.txnAmt,
          {
            color:
              item.type === "Income"
                ? COLORS.green
                : COLORS.danger,
          },
        ]}
      >
        {item.type === "Income" ? "+" : "-"}₹
        {item.amount.toLocaleString("en-IN")}
      </Text>
    </View>
  );

  /* ================================================= */

  return (
    <FlatList
      data={recent}
      renderItem={renderItem}
      keyExtractor={(item) => String(item.id)}
      ListHeaderComponent={renderHeader}
      contentContainerStyle={{ paddingBottom: 48 }}
      refreshing={loading}
      onRefresh={loadDashboard}
    />
  );
};

export default Dashboard;
