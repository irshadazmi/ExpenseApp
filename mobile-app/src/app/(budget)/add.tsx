import { View, Text, Pressable } from "react-native";
import { useRouter } from "expo-router";

import { useStyles } from "@/styles/styles";
import { useAppColors } from "@/hooks/use-app-colors";
import BudgetForm from "@/components/budget-form";

const AddBudget = () => {
  const styles = useStyles();
  const COLORS = useAppColors();
  const router = useRouter();

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
          Add Budget
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

      <BudgetForm />
    </View>
  );
};

export default AddBudget;
