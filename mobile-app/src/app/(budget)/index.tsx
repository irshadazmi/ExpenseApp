// mobile-app/src/app/(budget)/index.tsx
import React, { useEffect, useState } from "react";
import {
  View,
  Text,
  FlatList,
  Pressable,
  ActivityIndicator,
  Alert,
} from "react-native";

import { useStyles } from "@/styles/styles";
import { useAppColors } from "@/hooks/use-app-colors";
import { budgetService } from "@/services/budget-service";
import { BudgetResponse } from "@/types/budget";
import { RelativePathString, useRouter } from "expo-router";
import { useAuth } from "@/contexts/auth-context";

/* ======================================================
    BUDGET LIST
====================================================== */

const Budgets = () => {
  const styles = useStyles();
  const COLORS = useAppColors();

  const [budgets, setBudgets] = useState<BudgetResponse[]>([]);
  const [loading, setLoading] = useState(false);

  const router = useRouter();
  const { user } = useAuth();

  const currentUserId = user?.id;

  /* ======================================================
      LOAD DATA
  ====================================================== */

  const loadBudgets = async () => {
    setLoading(true);
    try {
      const data = await budgetService.getByUser(currentUserId!);
      setBudgets(data || []);
    } catch {
      Alert.alert("Error", "Failed to load budgets");
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    loadBudgets();
  }, []);

  /* ======================================================
      NAVIGATION
  ====================================================== */

  const handleEditAll = () => {
    router.push("/(budget)/edit-all" as RelativePathString);
  };

  /* ======================================================
      RENDER ITEM
  ====================================================== */

  const renderItem = ({ item }: { item: BudgetResponse }) => {
    const isTotal = item.category_id === 0;

    return (
      <View
        style={[
          styles.card,
          isTotal && {
            borderLeftWidth: 4,
            borderLeftColor: COLORS.primary,
            opacity: 0.95,
          },
        ]}
      >
        <View style={styles.metaRow}>
          <Text style={styles.cardTitle}>
            {item.name}
            {isTotal && (
              <Text style={{ color: COLORS.primary }}>
                {" "}• Total
              </Text>
            )}
          </Text>
        </View>

        <View style={styles.metaRow}>
          <Text style={styles.metaText}>
            💰 {item.currency}{" "}
            {Number(item.amount).toLocaleString("en-IN")}
          </Text>

          <Text style={styles.metaText}>
            ⏱ {item.period}
          </Text>
        </View>
      </View>
    );
  };

  /* ======================================================
      UI
  ====================================================== */

  return (
    <View style={styles.container}>
      {/* HEADER */}
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
          Budgets
        </Text>

        <Pressable onPress={handleEditAll}>
          <Text
            style={{
              color: COLORS.primary,
              fontSize: 14,
              fontWeight: "600",
            }}
          >
            Edit Budgets
          </Text>
        </Pressable>
      </View>

      {loading ? (
        <ActivityIndicator size="large" color={COLORS.primary} />
      ) : (
        <FlatList
          data={budgets}
          keyExtractor={(item) => item.id!.toString()}
          renderItem={renderItem}
          onRefresh={loadBudgets}
          refreshing={loading}
          contentContainerStyle={{ paddingBottom: 50 }}
        />
      )}
    </View>
  );
};

export default Budgets;
