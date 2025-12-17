// src/app/(transaction)/add.tsx

import { View, Text, Pressable } from "react-native";
import { useRouter } from "expo-router";

import { useStyles } from "@/styles/styles";
import { useAppColors } from "@/hooks/use-app-colors";
import TransactionForm from "@/components/transaction-form";

const AddTransaction = () => {
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
          Add Transaction
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

      <TransactionForm />
    </View>
  );
};

export default AddTransaction;
