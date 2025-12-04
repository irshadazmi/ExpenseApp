// mobile-app/src/app/dashboard.tsx

import React, { useCallback, useEffect, useMemo, useState } from "react";
import {
  View,
  FlatList,
  Text,
  Dimensions,
  ScrollView,
  TouchableOpacity,
} from "react-native";

import Svg, { Rect, Text as SvgText } from "react-native-svg";
import { PieChart } from "react-native-chart-kit";

import styles from "@/styles/styles";
import { COLORS } from "@/constants/COLORS";
import { MONTHS, toApiMonth } from "@/constants/MONTHS";

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

  const now = new Date();
  const currentYear = now.getFullYear();
  const currentMonthIndex = now.getMonth(); // 0..11

  const [summary, setSummary] = useState<DashboardSummary | null>(null);
  const [categories, setCategories] = useState<CategoryReportItem[]>([]);
  const [recent, setRecent] = useState<RecentTransaction[]>([]);
  const [loading, setLoading] = useState(false);

  const [selectedYear, setSelectedYear] = useState<number>(currentYear);
  const [selectedMonthIndex, setSelectedMonthIndex] =
    useState<number>(-1); // ✅ Default = "ALL months"

  // 5 years range centered around current
  const yearOptions = useMemo(
    () => [
      currentYear - 4,
      currentYear - 3,
      currentYear - 2,
      currentYear - 1,
      currentYear,
    ],
    [currentYear]
  );

  /* ======================================================
        DATA FETCH
  ====================================================== */

  const loadData = useCallback(async () => {
    if (!user) return;

    setLoading(true);
    try {
      const yearForApi = selectedYear;
      const monthForApi =
        selectedMonthIndex >= 0 ? toApiMonth(selectedMonthIndex) : undefined;

      const [s, c, r] = await Promise.all([
        dashboardService.getSummary(
          user.id,
          yearForApi,
          monthForApi
        ),
        dashboardService.getCategories(
          user.id,
          yearForApi,
          monthForApi
        ),
        dashboardService.getRecent(
          user.id,
          yearForApi,
          monthForApi
        ),
      ]);

      setSummary(s);
      setCategories(c || []);
      setRecent((r || []).slice(0, 6));
    } catch (e) {
      console.log("Dashboard load error:", e);
    } finally {
      setLoading(false);
    }
  }, [user, selectedYear, selectedMonthIndex]);

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
        short_name: c.short_name,
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
  };

  /* ======================================================
        LOADING STATE
  ====================================================== */

  if (!summary) {
    return (
      <View style={styles.container}>
        <Text style={styles.title}>
          {loading ? "Loading dashboard..." : "Unable to load dashboard"}
        </Text>
      </View>
    );
  }

  /* ======================================================
        UI COMPONENTS
  ====================================================== */

  /* ---------- YEAR + MONTH CHIPS (TWO ROW SELECTOR) ---------- */

  const YearMonthSelector = () => (
    <View style={{ marginBottom: 8 }}>

      {/* ====================
        YEAR ROW
    ==================== */}
      <Text style={styles.label}>Year</Text>

      <ScrollView
        horizontal
        showsHorizontalScrollIndicator={false}
        contentContainerStyle={{
          paddingHorizontal: 12,
          flexDirection: "row",
          alignItems: "center",
        }}
      >
        {yearOptions.map((y) => {
          const active = y === selectedYear;

          return (
            <TouchableOpacity
              key={y}
              onPress={() => setSelectedYear(y)}
              style={[
                styles.chip,
                active && styles.chipSelected,
              ]}
            >
              <Text
                style={[
                  styles.chipText,
                  active && styles.chipTextSelected,
                ]}
              >
                {y}
              </Text>
            </TouchableOpacity>
          );
        })}
      </ScrollView>

      {/* ====================
        MONTH ROW
    ==================== */}
      <Text style={[styles.label, { marginTop: 6 }]}>Month</Text>

      <ScrollView
        horizontal
        showsHorizontalScrollIndicator={false}
        contentContainerStyle={{
          paddingHorizontal: 12,
          flexDirection: "row",
          alignItems: "center",
        }}
      >

        {/* ALL */}
        <TouchableOpacity
          onPress={() => setSelectedMonthIndex(-1)}
          style={[
            styles.chip,
            selectedMonthIndex === -1 && styles.chipSelected,
          ]}
        >
          <Text
            style={[
              styles.chipText,
              selectedMonthIndex === -1 && styles.chipTextSelected,
            ]}
          >
            ALL
          </Text>
        </TouchableOpacity>

        {/* MONTHS */}
        {MONTHS.map((m, i) => {
          const active = i === selectedMonthIndex;

          return (
            <TouchableOpacity
              key={m}
              onPress={() => setSelectedMonthIndex(i)}
              style={[
                styles.chip,
                active && styles.chipSelected,
              ]}
            >
              <Text
                style={[
                  styles.chipText,
                  active && styles.chipTextSelected,
                ]}
              >
                {m}
              </Text>
            </TouchableOpacity>
          );
        })}
      </ScrollView>
    </View>
  );


  /* ---------- KPI CARDS ---------- */

  const KPIs = () => (
    <View style={styles.dashboardCardRow}>
      <View style={styles.card}>
        <Text style={styles.label}>TOTAL BUDGET</Text>
        <Text style={styles.title}>
          ₹{summary.totals.budget.toLocaleString("en-IN")}
        </Text>
        <Text style={{ color: COLORS.green, fontSize: 14 }}>
          Income: ₹{summary.totals.earning.toLocaleString("en-IN")}
        </Text>
      </View>

      <View style={styles.card}>
        <Text style={styles.label}>TOTAL SPENT</Text>
        <Text style={[styles.title, { color: COLORS.danger }]}>
          ₹{summary.totals.spent.toLocaleString("en-IN")}
        </Text>
        <Text style={{ color: COLORS.green, fontSize: 14 }}>
          Remaining: ₹{summary.totals.remaining.toLocaleString("en-IN")}
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
          <Text style={styles.label}>Usage</Text>
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

        <View style={{ marginTop: 6, flexDirection: "row", justifyContent: "space-between" }}>
          <Text style={styles.metaText}>
            Daily spent: ₹{Math.round(summary.burn_rate.daily_spend || 0)}
          </Text>
          <Text style={styles.metaText}>
            Allowed/day: ₹{Math.round(summary.burn_rate.daily_budget || 0)}
          </Text>
        </View>
      </View>
    );
  };

  /* ---------- SPENDING CHART ---------- */

  const SpendingChart = () => {
    const width = categories.length * (BAR_WIDTH + BAR_GAP) + 40;

    return (
      <View style={styles.dashboardChartBox}>
        <Text style={styles.dashboardChartTitle}>Spending vs Budget</Text>

        <ScrollView horizontal showsHorizontalScrollIndicator={false}>
          <Svg
            width={Math.max(width, screenWidth)}
            height={BAR_HEIGHT + LABEL_HEIGHT}
          >
            {categories.map((c, i) => {
              const budgetH = (c.budget / maxBarValue) * BAR_HEIGHT;
              const spentH = (c.spent / maxBarValue) * BAR_HEIGHT;

              const x = i * (BAR_WIDTH + BAR_GAP) + 30;
              const yBudget = BAR_HEIGHT - budgetH;
              const ySpent = yBudget + (budgetH - spentH);

              return (
                <React.Fragment key={i}>
                  <Rect
                    x={x}
                    y={yBudget}
                    width={BAR_WIDTH}
                    height={budgetH}
                    rx={4}
                    fill={COLORS.textSecondary}
                    opacity={0.35}
                  />

                  <Rect
                    x={x}
                    y={ySpent}
                    width={BAR_WIDTH}
                    height={spentH}
                    rx={4}
                    fill={PIE_COLORS[i % PIE_COLORS.length]}
                  />

                  <SvgText
                    x={x + BAR_WIDTH / 2}
                    y={BAR_HEIGHT + 16}
                    fontSize={10}
                    fill={COLORS.textSecondary}
                    textAnchor="middle"
                    rotation="-40"
                    origin={`${x + BAR_WIDTH / 2},${BAR_HEIGHT + 16}`}
                  >
                    {c.short_name}
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
      <Text style={styles.dashboardChartTitle}>
        Latest Transactions: {recent.length}
      </Text>

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
          <YearMonthSelector />
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
