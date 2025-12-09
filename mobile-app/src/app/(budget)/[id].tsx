import { View, Text, Pressable } from "react-native";
import { useRouter, useLocalSearchParams } from "expo-router";

import { useStyles } from "@/styles/styles";
import { useAppColors } from "@/hooks/use-app-colors";
import BudgetForm from "@/components/budget-form";

const EditBudget = () => {
  const styles = useStyles();
  const COLORS = useAppColors();
  const router = useRouter();

  const { id } = useLocalSearchParams();

  // ✅ Ensure proper number conversion for BudgetForm
  const budgetId = id ? Number(id) : undefined;

  return (
    <View style={styles.container}>
      {/* ================= HEADER ================= */}

      <View
        style={{
          flexDirection: "row",
          alignItems: "center",
          marginBottom: 16,
        }}
      >
        <Text
          style={[
            styles.title,
            {
              flex: 1,
              textAlign: "left",
              marginBottom: 0,
            },
          ]}
        >
          Edit Budget
        </Text>

        <Pressable onPress={() => router.back()}>
          <Text
            style={{
              color: COLORS.primary,
              fontSize: 14,
              fontWeight: "600",
            }}
          >
            Back to List
          </Text>
        </Pressable>
      </View>

      {/* ================= FORM ================= */}

      <BudgetForm id={budgetId} />
    </View>
  );
};

export default EditBudget;
