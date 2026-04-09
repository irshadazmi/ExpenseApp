// mobile-app/src/app/(dashboard)/index.tsx
import React, { useCallback, useEffect, useState } from "react";
import { View, FlatList } from "react-native";

import { useStyles } from "@/styles/styles";
import { useAppColors } from "@/hooks/use-app-colors";
import { useAuth } from "@/contexts/auth-context";

import { dashboardService } from "@/services/dashboard-service";

import {
  DashboardSummary,
  CategoryReportItem,
  RecentTransaction,
} from "@/types/dashboard";

import { YearMonthSelector } from "@/components/dashboard/year-month-selector";
import { KPIs } from "@/components/dashboard/KPIs";
import { UsageBar } from "@/components/dashboard/usage-bar";
import { ExpenseByCategory } from "@/components/dashboard/expense-by-category";
import { SpendingVsBudget } from "@/components/dashboard/spending-vs-budget";
import { LatestTransactions } from "@/components/dashboard/latest-transactions";

import { toApiMonth } from "@/constants/MONTHS";

/* ======================================================
   Skeleton
====================================================== */

type SkeletonBoxProps = { height?: number };

const SkeletonBox = ({ height = 140 }: SkeletonBoxProps) => {
  const COLORS = useAppColors();
  return (
    <View
      style={{
        height,
        borderRadius: 12,
        backgroundColor: COLORS.skeleton,
        marginVertical: 8,
        opacity: 0.6,
      }}
    />
  );
};

/* ======================================================
   Dashboard
====================================================== */

export default function Dashboard() {
  const styles = useStyles();
  const { user } = useAuth();

  const now = new Date();
  const currentYear = now.getFullYear();
  const currentMonthIndex = now.getMonth();

  const [summary, setSummary] = useState<DashboardSummary | null>(null);
  const [categories, setCategories] = useState<CategoryReportItem[]>([]);
  const [recent, setRecent] = useState<RecentTransaction[]>([]);
  const [loading, setLoading] = useState(false);

  const [selectedYear, setSelectedYear] = useState(currentYear);
  const [selectedMonthIndex, setSelectedMonthIndex] =
    useState<number>(currentMonthIndex); // use -1 for "All"

  /* ======================================================
     Load Dashboard Data
  ====================================================== */

  const loadData = useCallback(async () => {
    if (!user?.id) return;

    setLoading(true);
    try {
      const monthForApi =
        selectedMonthIndex === -1
          ? undefined
          : toApiMonth(selectedMonthIndex);

      const [s, c, r] = await Promise.all([
        dashboardService.getSummary(user.id, selectedYear, monthForApi),
        dashboardService.getCategories(user.id, selectedYear, monthForApi),
        dashboardService.getRecent(user.id, selectedYear, monthForApi),
      ]);

      setSummary(s);
      setCategories(c ?? []);
      setRecent((r ?? []).slice(0, 6));
    } catch (err) {
      console.error("Dashboard error:", err);
    } finally {
      setLoading(false);
    }
  }, [user?.id, selectedYear, selectedMonthIndex]);

  useEffect(() => {
    loadData();
  }, [loadData]);

  /* ======================================================
     Loading State
  ====================================================== */

  if (loading || !summary) {
    return (
      <View style={styles.dashboardHeaderContainer}>
        <YearMonthSelector
          selectedYear={selectedYear}
          setSelectedYear={setSelectedYear}
          selectedMonthIndex={selectedMonthIndex}
          setSelectedMonthIndex={setSelectedMonthIndex}
          currentYear={currentYear}
        />
        <SkeletonBox />
        <SkeletonBox height={100} />
        <SkeletonBox height={260} />
        <SkeletonBox height={220} />
      </View>
    );
  }

  /* ======================================================
     Render
  ====================================================== */

  return (
    <View style={styles.container}>
      <FlatList
        data={[]}
        renderItem={() => null}
        keyExtractor={(_, i) => `dashboard-${i}`}
        refreshing={loading}
        onRefresh={loadData}
        stickyHeaderIndices={[0]}
        contentContainerStyle={{ padding: 5 }}
        ListHeaderComponent={
          <View style={styles.dashboardHeaderContainer}>
            <YearMonthSelector
              selectedYear={selectedYear}
              setSelectedYear={setSelectedYear}
              selectedMonthIndex={selectedMonthIndex}
              setSelectedMonthIndex={setSelectedMonthIndex}
              currentYear={currentYear}
            />
          </View>
        }
        ListFooterComponent={
          <>
            <KPIs summary={summary} />
            <UsageBar summary={summary} />
            <ExpenseByCategory categories={categories} />
            <SpendingVsBudget categories={categories} />
            <LatestTransactions transactions={recent} />
          </>
        }
      />
    </View>
  );
}
