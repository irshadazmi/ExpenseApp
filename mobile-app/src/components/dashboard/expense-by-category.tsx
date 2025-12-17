// mobile-app/src/app/(dashboard)/components/expense-by-category.tsx
import React from "react";
import { Dimensions, View, Text, ScrollView } from "react-native";
import { PieChart } from "react-native-chart-kit";

import { useStyles } from "@/styles/styles";
import { useAppColors } from "@/hooks/use-app-colors";
import { CategoryReportItem } from "@/types/dashboard";

const screenWidth = Dimensions.get("window").width;

interface ExpenseByCategoryProps {
  categories: CategoryReportItem[];
}

const CHART_COLORS = {
  violet: "#7C4DFF",
  teal: "#26A69A",
  coral: "#FF7043",
  blue: "#42A5F5",
  purple: "#AB47BC",
  amber: "#FFCA28",
  pink: "#EC407A",
  green: "#66BB6A",
  sky: "#29B6F6",
  peach: "#FF8A65",
};

const PIE_COLORS = Object.values(CHART_COLORS);

export const ExpenseByCategory: React.FC<ExpenseByCategoryProps> = ({ categories }) => {
  const styles = useStyles();
  const COLORS = useAppColors();

  const pieData = categories
    .filter((c) => c.spent > 0)
    .map((c, i) => ({
      name: c.category_name,
      population: c.spent,
      color: PIE_COLORS[i % PIE_COLORS.length],
      legendFontColor: COLORS.legendText,
      legendFontSize: 12,
    }));

  const chartConfig = {
    backgroundGradientFrom: "transparent",
    backgroundGradientTo: "transparent",
    color: () => COLORS.text,
    labelColor: () => COLORS.legendText,
    propsForBackgroundLines: {
      stroke: COLORS.divider,
    },
  };

  if (pieData.length === 0) return null;

  return (
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
};
