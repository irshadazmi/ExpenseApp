// mobile-app/src/app/dashboard.tsx
import React, {
  useCallback,
  useEffect,
  useMemo,
  useRef,
  useState,
} from "react";
import {
  View,
  FlatList,
  Text,
  Dimensions,
  ScrollView,
  Pressable,
  Animated,
  PanResponder,
} from "react-native";

import Svg, { Rect, Text as SvgText } from "react-native-svg";
import { PieChart } from "react-native-chart-kit";
import * as Haptics from "expo-haptics";
import  styles from "@/styles/styles";

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
    SMALL REUSABLE COMPONENTS
====================================================== */

const AnimatedChip = ({
  label,
  active,
  onPress,
}: {
  label: string | number;
  active: boolean;
  onPress: () => void;
}) => {
  const scale = useRef(new Animated.Value(1)).current;

  const pressIn = () =>
    Animated.spring(scale, {
      toValue: 0.92,
      useNativeDriver: true,
    }).start();

  const pressOut = async () => {
    await Haptics.impactAsync(Haptics.ImpactFeedbackStyle.Light);

    Animated.spring(scale, {
      toValue: 1,
      friction: 3,
      tension: 40,
      useNativeDriver: true,
    }).start();

    onPress();
  };

  return (
    <Pressable onPressIn={pressIn} onPressOut={pressOut}>
      <Animated.View
        style={[
          styles.chip,
          active && styles.chipSelected,
          { transform: [{ scale }] },
        ]}
      >
        <Text style={[styles.chipText, active && styles.chipTextSelected]}>
          {label}
        </Text>
      </Animated.View>
    </Pressable>
  );
};

const SkeletonBox = ({ height = 140 }) => (
  <View
    style={{
      height,
      borderRadius: 12,
      backgroundColor: "#EEE",
      marginVertical: 8,
      opacity: 0.6,
    }}
  />
);

/* ======================================================
    DASHBOARD
====================================================== */

export default function Dashboard() {
  const { user } = useAuth();

  const now = new Date();
  const currentYear = now.getFullYear();
  const currentMonthIndex = now.getMonth();

  const [summary, setSummary] =
    useState<DashboardSummary | null>(null);
  const [categories, setCategories] =
    useState<CategoryReportItem[]>([]);
  const [recent, setRecent] =
    useState<RecentTransaction[]>([]);
  const [loading, setLoading] = useState(false);

  const [selectedYear, setSelectedYear] =
    useState<number>(currentYear);

  // default = current month
  const [selectedMonthIndex, setSelectedMonthIndex] =
    useState<number>(currentMonthIndex);

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
        MONTH / QUARTER STATE
====================================================== */

  const quarterIndex = useMemo(() => {
    if (selectedMonthIndex < 0) return -1;
    return Math.floor(selectedMonthIndex / 3);
  }, [selectedMonthIndex]);

  // visible months only from active quarter
  const visibleMonths = useMemo(() => {
    if (quarterIndex < 0) return [];

    const start = quarterIndex * 3;
    return MONTHS.slice(start, start + 3).map((m, i) => ({
      label: m,
      index: start + i,
    }));
  }, [quarterIndex]);

  /* ======================================================
        MONTH SCROLL STABILITY
====================================================== */

  const monthScrollRef = useRef<ScrollView>(null);
  const quarterAnim = useRef(new Animated.Value(1)).current;

  const animateQuarter = () => {
    quarterAnim.setValue(0.9);
    Animated.spring(quarterAnim, {
      toValue: 1,
      friction: 5,
      tension: 45,
      useNativeDriver: true,
    }).start();
  };

  useEffect(() => {
    animateQuarter();
  }, [quarterIndex]);

  /* ======================================================
        SWIPE HANDLER
====================================================== */

  const monthSwipe = useRef(
    PanResponder.create({
      onMoveShouldSetPanResponder: (_, g) =>
        Math.abs(g.dx) > 20,
      onPanResponderRelease: (_, g) => {
        if (g.dx < -40)
          setSelectedMonthIndex((p) =>
            Math.min(p + 1, 11)
          );

        if (g.dx > 40)
          setSelectedMonthIndex((p) =>
            Math.max(p - 1, 0)
          );
      },
    })
  ).current;

  /* ======================================================
        DATA FETCH
====================================================== */

  const loadData = useCallback(async () => {
    if (!user) return;

    setLoading(true);

    try {
      const monthForApi =
        selectedMonthIndex >= 0
          ? toApiMonth(selectedMonthIndex)
          : undefined;

      const [s, c, r] = await Promise.all([
        dashboardService.getSummary(
          user.id,
          selectedYear,
          monthForApi
        ),
        dashboardService.getCategories(
          user.id,
          selectedYear,
          monthForApi
        ),
        dashboardService.getRecent(
          user.id,
          selectedYear,
          monthForApi
        ),
      ]);

      setSummary(s);
      setCategories(c || []);
      setRecent((r || []).slice(0, 6));
    } catch (err) {
      console.log("Dashboard load error:", err);
    } finally {
      setLoading(false);
    }
  }, [user, selectedYear, selectedMonthIndex]);

  useEffect(() => {
    loadData();
  }, [loadData]);

  /* ======================================================
        SHARED CALCS
====================================================== */

  const maxBarValue = useMemo(
    () =>
      Math.max(
        ...categories.map((c) =>
          Math.max(c.spent || 0, c.budget || 0)
        ),
        1
      ),
    [categories]
  );

  const pieData = useMemo(
    () =>
      categories
        .filter((c) => c.spent > 0)
        .map((c, i) => ({
          name: c.category_name,
          population: c.spent,
          color: PIE_COLORS[i % PIE_COLORS.length],
          legendFontColor: COLORS.text,
          legendFontSize: 12,
        })),
    [categories]
  );

  const chartConfig = {
    // backgroundGradientFrom: COLORS.white,
    // backgroundGradientTo: COLORS.white,
    color: () => `rgba(0,0,0,1)`,
    labelColor: () => `rgba(0,0,0,1)`,
  };

  /* ======================================================
      SELECTOR
====================================================== */

  const YearMonthSelector = () => (
    <View>

      {/* ---------- YEAR ---------- */}
      <View style={styles.chipsContainer}>
        <Text style={styles.chipLabel}>Year:</Text>
        <ScrollView
          horizontal
          showsHorizontalScrollIndicator={false}
        >
          {yearOptions.map((y) => (
            <AnimatedChip
              key={y}
              label={y}
              active={y === selectedYear}
              onPress={() => setSelectedYear(y)}
            />
          ))}
        </ScrollView>
      </View>

      {/* ---------- QUARTER ---------- */}
      <View style={styles.chipsContainer}>
        <Text style={styles.chipLabel}>Quarter:</Text>
        <ScrollView
          horizontal
          showsHorizontalScrollIndicator={false}
        >
          {["Q1", "Q2", "Q3", "Q4"].map((q, idx) => {
            const start = idx * 3;
            const active = quarterIndex === idx;

            return (
              <AnimatedChip
                key={q}
                label={q}
                active={active}
                onPress={() => setSelectedMonthIndex(start)}
              />
            );
          })}
        </ScrollView>
      </View>

      {/* ---------- MONTH ---------- */}
      <View style={styles.chipsContainer}>
        <Text style={styles.chipLabel}>Month:</Text>

        <Animated.View
          style={{
            transform: [{ scale: quarterAnim }],
            opacity: quarterAnim,
          }}
        >
          <ScrollView
            ref={monthScrollRef}
            horizontal
            {...monthSwipe.panHandlers}
            showsHorizontalScrollIndicator={false}
          >
            <AnimatedChip
              label="All"
              active={selectedMonthIndex === -1}
              onPress={() => setSelectedMonthIndex(-1)}
            />

            {visibleMonths.map((m) => (
              <AnimatedChip
                key={m.index}
                label={m.label}
                active={m.index === selectedMonthIndex}
                onPress={() => setSelectedMonthIndex(m.index)}
              />
            ))}
          </ScrollView>
        </Animated.View>

      </View>
    </View>
  );


  /* ======================================================
        PERIOD BADGE
====================================================== */

  const periodLabel =
    selectedMonthIndex === -1
      ? `${selectedYear} • ALL`
      : `${selectedYear} • ${MONTHS[selectedMonthIndex]}`;

  const PeriodBadge = () => (
    <View
      style={styles.dashboardBadgeContainer}
    >
      <Text
        style={styles.dashboardBadgeText}
      >
        {periodLabel}
      </Text>
    </View>
  );

  /* ======================================================
        LOADING
====================================================== */

  if (loading || !summary) {
    return (
      <View style={styles.dashboardHeaderContainer}>
        <YearMonthSelector />
        <SkeletonBox />
        <SkeletonBox height={100} />
        <SkeletonBox height={260} />
        <SkeletonBox height={220} />
      </View>
    );
  }

  /* ======================================================
        UI COMPONENTS
====================================================== */

  const KPIs = () => (
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
    const width =
      categories.length * (BAR_WIDTH + BAR_GAP) + 40;

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
              const budgetH =
                (c.budget / maxBarValue) * BAR_HEIGHT;
              const spentH =
                (c.spent / maxBarValue) * BAR_HEIGHT;

              const x =
                i * (BAR_WIDTH + BAR_GAP) + 30;

              const yBudget =
                BAR_HEIGHT - budgetH;

              const ySpent =
                yBudget + (budgetH - spentH);

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
                    fill={
                      PIE_COLORS[i % PIE_COLORS.length]
                    }
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
    <View style={styles.container}>
      <FlatList
        style={{ flex: 1 }}
        contentContainerStyle={{ padding: 5 }}
        data={[]}
        stickyHeaderIndices={[0]}
        refreshing={loading}
        onRefresh={loadData}
        renderItem={null}
        keyExtractor={() => "dashboard"}
        ListHeaderComponent={
          <View style={styles.dashboardHeaderContainer}>
            <YearMonthSelector />
          </View>
        }
        ListFooterComponent={
          <>
            <PeriodBadge />
            <KPIs />
            <UsageBar />
            <ExpensePieChart />
            <SpendingChart />
            <Transactions />
          </>
        }
      />
    </View>
  );
}
