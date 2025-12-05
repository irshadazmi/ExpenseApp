import { View, Text, Pressable } from "react-native";
import { useRouter } from "expo-router";

import styles from "@/styles/styles";
import { COLORS } from "@/constants/COLORS";
import BudgetForm from "@/components/budget-form";

const AddBudget = () => {
  const router = useRouter();

  return (
    <View style={styles.container}>

      {/* Header: Title + Back */}
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
            { flex: 1, textAlign: "left", marginBottom: 0 },
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

      <BudgetForm />
    </View>
  );
};

export default AddBudget;
