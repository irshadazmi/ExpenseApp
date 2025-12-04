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
import { Picker } from "@react-native-picker/picker";

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

  // Current year defaults
  const now = new Date();
  const currentYear = now.getFullYear();

  const [summary, setSummary] = useState<DashboardSummary | null>(null);
  const [categories, setCategories] = useState<CategoryReportItem[]>([]);
  const [recent, setRecent] = useState<RecentTransaction[]>([]);
  const [loading, setLoading] = useState(false);

  // ✅ Defaults:
  // Year = current year
  // Month = unselected (-1)
  const [selectedYear, setSelectedYear] = useState<number>(currentYear);
  const [selectedMonthIndex, setSelectedMonthIndex] =
    useState<number>(-1);

  // Year dropdown (current + last 4)
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
      const yearForApi =
        selectedYear > 0 ? selectedYear : undefined;

      const monthForApi =
        selectedMonthIndex >= 0
          ? toApiMonth(selectedMonthIndex)
          : undefined;

      const summaryReq =
        dashboardService
          .getSummary(user.id, yearForApi, monthForApi)
          .catch((e) => {
            console.log("Summary API failed:", e);
            return null;
          });

      const catReq =
        dashboardService
          .getCategories(user.id, yearForApi, monthForApi)
          .catch((e) => {
            console.log("Categories API failed:", e);
            return [];
          });

      const recentReq =
        dashboardService
          .getRecent(user.id, yearForApi, monthForApi)
          .catch((e) => {
            console.log("Recent API failed:", e);
            return [];
          });

      const [s, c, r] = await Promise.all([
        summaryReq,
        catReq,
        recentReq,
      ]);

      setSummary(s);
      setCategories(c || []);
      setRecent((r || []).slice(0, 6));
    }
    catch (e) {
      console.log("Unexpected dashboard error:", e);
    }
    finally {
      setLoading(false);
    }

  }, [user, selectedYear, selectedMonthIndex]);

  /* ======================================================
        INITIAL LOAD
  ====================================================== */

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
        name: c.short_name,
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

  /* ---------- KPI ---------- */

  const KPIs = () => (
    <View style={styles.dashboardCardRow}>
      <View style={styles.card}>
        <Text style={styles.label}>TOTAL BUDGET</Text>
        <Text style={styles.title}>
          ₹{summary.totals.budget.toLocaleString("en-IN")}
        </Text>
        <Text style={{ color: COLORS.green, fontWeight: "700" }}>
          Income: ₹{summary.totals.earning.toLocaleString("en-IN")}
        </Text>
      </View>

      <View style={styles.card}>
        <Text style={styles.label}>TOTAL SPENT</Text>
        <Text style={[styles.title, { color: COLORS.danger }]}>
          ₹{summary.totals.spent.toLocaleString("en-IN")}
        </Text>
        <Text style={{ color: COLORS.green, fontWeight: "700" }}>
          Remaining: ₹{summary.totals.remaining.toLocaleString("en-IN")}
        </Text>
      </View>
    </View>
  );

  /* ---------- USAGE ---------- */

  const UsageBar = () => {
    const usage = summary.totals.usage_percent || 0;
    const capped = Math.min(usage, 200);

    let color = COLORS.primary;
    if (usage > 100) color = COLORS.danger;
    else if (usage > 80) color = "#FFB000";

    return (
      <View style={styles.dashboardUsageBox}>
        <Text style={styles.label}>
          Monthly Usage: {usage.toFixed(1)}%
        </Text>

        <View style={styles.barBg}>
          <View
            style={[
              styles.barFill,
              { width: `${capped}%`, backgroundColor: color },
            ]}
          />
        </View>

        <View style={{ marginTop: 6 }}>
          <Text style={styles.metaText}>
            Daily spent: ₹{Math.round(summary.burn_rate.daily_spend)}
          </Text>
          <Text style={styles.metaText}>
            Allowed/day: ₹{Math.round(summary.burn_rate.daily_budget)}
          </Text>
        </View>
      </View>
    );
  };

  /* ---------- SPENDING VS BUDGET ---------- */

  const SpendingChart = () => {
    const width = categories.length * (BAR_WIDTH + BAR_GAP) + 40;

    return (
      <View style={styles.dashboardChartBox}>
        <Text style={styles.dashboardChartTitle}>
          Spending vs Budget
        </Text>

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
                    rotation="-40"
                    fontSize={10}
                    textAnchor="middle"
                    fill={COLORS.textSecondary}
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

  /* ---------- PIE ---------- */

  const ExpensePieChart = () =>
    pieData.length === 0 ? null : (
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
            <Text style={styles.cardTitle}>
              {t.description}
            </Text>

            <Text
              style={[
                styles.txnAmt,
                {
                  color:
                    t.type === "Income"
                      ? COLORS.green
                      : COLORS.red,
                },
              ]}
            >
              {t.type === "Income" ? "+" : "-"}₹
              {t.amount.toLocaleString("en-IN")}
            </Text>
          </View>

          <View style={styles.metaRow}>
            <Text style={styles.metaText}>
              {t.category}
            </Text>
            <Text style={styles.metaText}>
              {new Date(
                t.transaction_date
              ).toDateString()}
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

          {/* Filters */}
          <View style={{ flexDirection: "row" }}>
            <View style={[styles.dropdownWrapper, { flex: 1, marginRight: 8 }]}>
              <Picker
                selectedValue={selectedYear}
                style={styles.picker}
                onValueChange={(value) => setSelectedYear(value)}
              >
                {yearOptions.map((year) => (
                  <Picker.Item
                    key={year}
                    label={String(year)}
                    value={year}
                  />
                ))}
              </Picker>
            </View>

            <View style={[styles.dropdownWrapper, { flex: 1 }]}>
              <Picker
                selectedValue={selectedMonthIndex}
                style={styles.picker}
                onValueChange={(val) =>
                  setSelectedMonthIndex(Number(val))
                }
              >
                <Picker.Item
                  label="-- Select Month --"
                  value={-1}
                />
                {MONTHS.map((m, i) => (
                  <Picker.Item key={m} label={m} value={i} />
                ))}
              </Picker>
            </View>
          </View>

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
