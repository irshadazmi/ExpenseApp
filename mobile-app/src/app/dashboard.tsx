// mobile-app/src/app/dashboard.tsx

import React, { useCallback, useEffect, useMemo, useState } from "react";
import {
  View,
  FlatList,
  Text,
  Dimensions,
  ScrollView,
} from "react-native";

import Svg, { Rect, Text as SvgText } from "react-native-svg";
import { PieChart } from "react-native-chart-kit";

import styles from "@/styles/styles";
import { COLORS } from "@/constants/COLORS";

import { useAuth } from "@/contexts/auth-context";
import {
  dashboardService,
  DashboardSummary,
  CategoryReportItem,
  RecentTransaction,
} from "@/services/dashboard-service";

/* ======================================================
    CONSTANTS
====================================================== */

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

const BAR_HEIGHT = 200;
const BAR_WIDTH = 22;
const BAR_GAP = 24;
const LABEL_HEIGHT = 50;

const screenWidth = Dimensions.get("window").width;

/* ======================================================
    DASHBOARD
====================================================== */

export default function Dashboard() {
  const { user } = useAuth();

  const [summary, setSummary] = useState<DashboardSummary | null>(null);
  const [categories, setCategories] = useState<CategoryReportItem[]>([]);
  const [recent, setRecent] = useState<RecentTransaction[]>([]);
  const [loading, setLoading] = useState(false);

  /* ======================================================
        DATA FETCH
  ====================================================== */

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
      setCategories(c || []);
      setRecent((r || []).slice(0, 6));
    } catch (e) {
      console.log("Dashboard load error:", e);
    } finally {
      setLoading(false);
    }
  }, [user]);

  useEffect(() => {
    loadData();
  }, [loadData]);

  /* ======================================================
        SHARED CALCULATIONS
  ====================================================== */

  const maxBarValue = useMemo(
    () =>
      Math.max(
        ...categories.map((c) => Math.max(c.spent || 0, c.budget || 0)),
        1
      ),
    [categories]
  );

  const pieData = useMemo(() => {
    return categories
      .filter((c) => c.spent > 0)
      .map((c, i) => ({
        name: c.category_name,
        population: c.spent,
        color: PIE_COLORS[i % PIE_COLORS.length],
        legendFontColor: COLORS.text,
        legendFontSize: 12,
      }));
  }, [categories]);

  const chartConfig = {
    backgroundGradientFrom: COLORS.white,
    backgroundGradientTo: COLORS.white,
    color: (opacity = 1) => `rgba(0,0,0,${opacity})`,
    labelColor: (opacity = 1) => `rgba(0,0,0,${opacity})`,
    propsForBackgroundLines: {
      stroke: "#DDD",
      strokeDasharray: "3 3",
    },
  };

  /* ======================================================
        UI COMPONENTS
  ====================================================== */

  // Prevent early hook exit → safe loading screen
  if (!summary) {
    return (
      <View style={styles.container}>
        <Text style={styles.title}>Loading dashboard...</Text>
      </View>
    );
  }

  /* ---------- KPI CARDS ---------- */

  const KPIs = () => (
    <View style={styles.dashboardCardRow}>
      <View style={styles.card}>
        <Text style={styles.label}>TOTAL BUDGET</Text>
        <Text style={styles.title}>
          ₹{summary.totals.budget.toLocaleString("en-IN")}
        </Text>
        <Text style={{ color: COLORS.green, fontSize: 18, fontWeight: "700" }}>
          Income: ₹0
        </Text>
      </View>

      <View style={styles.card}>
        <Text style={styles.label}>TOTAL SPENT</Text>
        <Text style={[styles.title, { color: COLORS.danger }]}>
          ₹{summary.totals.spent.toLocaleString("en-IN")}
        </Text>
        <Text style={styles.text}>Transactions: {recent.length}</Text>
        <Text style={styles.text}>
          Remaining ₹{summary.totals.remaining.toLocaleString("en-IN")}
        </Text>
      </View>
    </View>
  );

  /* ---------- USAGE BAR ---------- */

  const UsageBar = () => {
    const usage = summary.totals.usage_percent || 0;
    const capped = Math.min(usage, 200);

    let color = COLORS.primary;
    if (usage > 100) color = COLORS.danger;
    else if (usage > 80) color = "#FFB000";

    return (
      <View style={styles.dashboardUsageBox}>
        <View style={{ flexDirection: "row", justifyContent: "space-between" }}>
          <Text style={styles.label}>Monthly Usage</Text>
          <Text style={styles.label}>{usage.toFixed(1)}%</Text>
        </View>

        <View style={styles.barBg}>
          <View
            style={[
              styles.barFill,
              { width: `${capped}%`, backgroundColor: color },
            ]}
          />
        </View>

        <View
          style={{
            marginTop: 6,
            flexDirection: "row",
            justifyContent: "space-between",
          }}
        >
          <Text style={styles.subValue}>
            Daily spent: ₹{Math.round(summary.burn_rate.daily_spend || 0)}
          </Text>
          <Text style={styles.subValue}>
            Allowed/day: ₹{Math.round(summary.burn_rate.daily_budget || 0)}
          </Text>
        </View>
      </View>
    );
  };

  /* ---------- SPENDING VS BUDGET ---------- */

  const SpendingChart = () => {
    const width =
      categories.length * (BAR_WIDTH * 2 + BAR_GAP) + 40;

    return (
      <View style={styles.dashboardChartBox}>
        <Text style={styles.dashboardChartTitle}>Spending vs Budget</Text>

        <ScrollView horizontal showsHorizontalScrollIndicator={false}>
          <Svg
            width={Math.max(width, screenWidth)}
            height={BAR_HEIGHT + LABEL_HEIGHT}
          >
            {categories.map((c, i) => {
              const spentH = (c.spent / maxBarValue) * BAR_HEIGHT;
              const budgetH = (c.budget / maxBarValue) * BAR_HEIGHT;
              const x = i * (BAR_WIDTH * 2 + BAR_GAP) + 30;

              return (
                <React.Fragment key={i}>
                  {/* Budget bar */}
                  <Rect
                    x={x}
                    y={BAR_HEIGHT - budgetH}
                    width={BAR_WIDTH}
                    height={budgetH}
                    rx={4}
                    fill="#CFD8DC"
                  />

                  {/* Spent bar */}
                  <Rect
                    x={x + BAR_WIDTH + 4}
                    y={BAR_HEIGHT - spentH}
                    width={BAR_WIDTH}
                    height={spentH}
                    rx={4}
                    fill={PIE_COLORS[i % PIE_COLORS.length]}
                  />

                  {/* Vertical label */}
                  <SvgText
                    x={x + BAR_WIDTH}
                    y={BAR_HEIGHT + 16}
                    fontSize={10}
                    fill={COLORS.textSecondary}
                    textAnchor="middle"
                    rotation="-40"
                    origin={`${x + BAR_WIDTH},${BAR_HEIGHT + 16}`}
                  >
                    {c.category_name}
                  </SvgText>
                </React.Fragment>
              );
            })}
          </Svg>
        </ScrollView>
      </View>
    );
  };

  /* ---------- PIE CHART ---------- */

  const ExpensePieChart = () =>
    pieData.length === 0 ? null : (
      <View style={styles.dashboardChartBox}>
        <Text style={styles.dashboardChartTitle}>Expenses by Category</Text>

        <PieChart
          data={pieData}
          width={screenWidth - 32}
          height={240}
          accessor="population"
          backgroundColor="transparent"
          chartConfig={chartConfig}
          hasLegend
          paddingLeft="16"
        />
      </View>
    );

  /* ---------- TRANSACTIONS ---------- */

  const Transactions = () => (
    <View style={styles.dashboardSection}>
      <Text style={styles.dashboardChartTitle}>Latest Transactions</Text>

      {recent.map((t) => (
        <View key={t.id} style={styles.card}>
          <View style={styles.metaRow}>
            <Text style={styles.cardTitle}>{t.description}</Text>
            <Text
              style={[
                styles.txnAmt,
                { color: t.type === "Income" ? COLORS.green : COLORS.red },
              ]}
            >
              {t.type === "Income" ? "+" : "-"}₹
              {t.amount.toLocaleString("en-IN")}
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

  /* ======================================================
        MAIN RENDER
  ====================================================== */

  return (
    <FlatList
      data={[]}
      refreshing={loading}
      onRefresh={loadData}
      keyExtractor={() => "dashboard"}
      ListHeaderComponent={
        <View style={styles.dashboardHeaderContainer}>
          <KPIs />
          <UsageBar />
          <ExpensePieChart />
          <SpendingChart />
          <Transactions />
        </View>
      }
      renderItem={null}
    />
  );
}
