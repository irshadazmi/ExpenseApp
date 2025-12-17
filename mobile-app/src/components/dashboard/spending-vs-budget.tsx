// mobile-app/src/app/(dashboard)/components/spending-vs-budget.tsx
import React from "react";
import { Dimensions, ScrollView, View, Text } from "react-native";
import Svg, { Rect, Text as SvgText } from "react-native-svg";

import { useStyles } from "@/styles/styles";
import { useAppColors } from "@/hooks/use-app-colors";
import { CategoryReportItem } from "@/types/dashboard";

const screenWidth = Dimensions.get("window").width;
const BAR_HEIGHT = 200;
const BAR_WIDTH = 22;
const BAR_GAP = 24;

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

interface SpendingVsBudgetProps {
  categories: CategoryReportItem[];
}

export const SpendingVsBudget: React.FC<SpendingVsBudgetProps> = ({ categories }) => {
  const styles = useStyles();
  const COLORS = useAppColors();

  const maxBarValue = Math.max(
    ...categories.map((c) => Math.max(c.spent || 0, c.budget || 0)),
    1
  );

  const width = categories.length * (BAR_WIDTH + BAR_GAP) + 40;

  return (
    <View style={styles.dashboardChartBox}>
      <Text style={styles.dashboardChartTitle}>Spending vs Budget</Text>
      <ScrollView horizontal>
        <Svg width={Math.max(width, screenWidth)} height={BAR_HEIGHT + 50}>
          {categories.map((c, i) => {
            const budgetH = (c.budget / maxBarValue) * BAR_HEIGHT;
            const spentH = (c.spent / maxBarValue) * BAR_HEIGHT;
            const projectedH =
              c.projected_spend != null ? (c.projected_spend / maxBarValue) * BAR_HEIGHT : null;

            const x = i * (BAR_WIDTH + BAR_GAP) + 30;

            return (
              <React.Fragment key={i}>
                {/* Budget */}
                <Rect
                  x={x}
                  y={BAR_HEIGHT - budgetH}
                  width={BAR_WIDTH}
                  height={budgetH}
                  rx={4}
                  fill={COLORS.textSecondary}
                  opacity={0.35}
                />

                {/* Spent */}
                <Rect
                  x={x}
                  y={BAR_HEIGHT - spentH}
                  width={BAR_WIDTH}
                  height={spentH}
                  rx={4}
                  fill={PIE_COLORS[i % PIE_COLORS.length]}
                />

                {/* Projected Spend Marker */}
                {projectedH !== null && (
                  <Rect
                    x={x - 2}
                    y={BAR_HEIGHT - projectedH}
                    width={BAR_WIDTH + 4}
                    height={2}
                    fill={COLORS.danger}
                  />
                )}

                {/* Label */}
                <SvgText
                  x={x + BAR_WIDTH / 2}
                  y={BAR_HEIGHT + 16}
                  fontSize={10}
                  fontWeight="700"
                  fill={COLORS.blue}
                  rotation="-90"
                  textAnchor="middle"
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
