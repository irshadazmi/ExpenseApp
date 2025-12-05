import React, { useEffect, useState } from "react";
import {
  View,
  Text,
  FlatList,
  Pressable,
  ActivityIndicator,
  Alert,
} from "react-native";

import styles from "@/styles/styles";
import { budgetService } from "@/services/budget-service";
import { COLORS } from "@/constants/COLORS";
import MaterialIcons from "@expo/vector-icons/MaterialIcons";

import { BudgetResponse } from "@/types/budget";
import { RelativePathString, useRouter } from "expo-router";
import { useAuth } from "@/contexts/auth-context";

/* ======================================================
    BUDGET LIST
====================================================== */

const Budgets = () => {
  const [budgets, setBudgets] = useState<BudgetResponse[]>([]);
  const [loading, setLoading] = useState(false);

  const router = useRouter();
  const { user } = useAuth();

  const isSuperAdmin = user?.role_id === 1;
  const currentUserId = user?.id;

  /* ======================================================
      LOAD DATA
  ====================================================== */

  const loadBudgets = async () => {
    setLoading(true);

    try {
      const data = isSuperAdmin
        ? await budgetService.getAll()
        : await budgetService.getByUser(currentUserId!);

      setBudgets(data);
    } catch (error) {
      console.error("Failed to load budgets", error);
      Alert.alert("Error", "Failed to load budgets. Please try again.");
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

  const handleAdd = () => {
    router.push("/(budget)/add" as RelativePathString);
  };

  const handleEdit = (item: BudgetResponse) => {
    if (!item.id) return;
    router.push(`/(budget)/${item.id}` as RelativePathString);
  };

  const handleDelete = async (item: BudgetResponse) => {
    if (!item.id) return;

    try {
      await budgetService.delete(item.id);
      await loadBudgets();
    } catch {
      Alert.alert("Error", "Failed to delete budget");
    }
  };

  /* ======================================================
      RENDER ITEM
  ====================================================== */

  const renderItem = ({ item }: { item: BudgetResponse }) => {
    const isActive = item.is_active;

    return (
      <View style={styles.card}>
        {/* HEADER ROW */}
        <View style={styles.cardHeader}>
          <Text style={styles.cardTitle}>
            {item.name}
          </Text>

          <View style={styles.statusBadge}>
            <Text
              style={[
                styles.statusText,
                {
                  color: isActive
                    ? COLORS.success
                    : COLORS.danger,
                },
              ]}
            >
              {isActive ? "ACTIVE" : "INACTIVE"}
            </Text>
          </View>
        </View>

        {/* META INFO */}
        <View style={styles.metaRow}>
          <Text style={styles.metaText}>
            💰 {item.currency} {Number(item.amount).toLocaleString("en-IN")}
          </Text>

          <Text style={styles.metaText}>
            ⏱ {item.period}
          </Text>
        </View>

        <View style={styles.metaRow}>
          <Text style={styles.metaText}>
            📅 {new Date(item.start_date).toLocaleDateString()} →{" "}
            {new Date(item.end_date).toLocaleDateString()}
          </Text>

          <Text style={styles.metaText}>
            🏷 Cat ID: {item.category_id}
          </Text>
        </View>

        {/* ACTIONS */}
        <View
          style={[
            styles.actionsRow,
            { marginTop: 6 },
          ]}
        >
          <Pressable
            style={[
              styles.actionButton,
              styles.editButton,
            ]}
            onPress={() => handleEdit(item)}
          >
            <MaterialIcons
              name="edit"
              size={16}
              color={COLORS.white}
            />
          </Pressable>

          <Pressable
            style={[
              styles.actionButton,
              styles.deleteButton,
            ]}
            onPress={() => handleDelete(item)}
          >
            <MaterialIcons
              name="delete"
              size={16}
              color={COLORS.white}
            />
          </Pressable>
        </View>
      </View>
    );
  };

  /* ======================================================
      UI
  ====================================================== */

  return (
    <View style={styles.container}>
      {/* Header row: title + Add button */}
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
          List Of Budgets
        </Text>

        <Pressable onPress={handleAdd}>
          <Text
            style={{
              color: COLORS.primary,
              fontSize: 14,
              fontWeight: "600",
            }}
          >
            + Add
          </Text>
        </Pressable>
      </View>

      {/* LOADING */}
      {loading ? (
        <ActivityIndicator
          style={{ marginTop: 20 }}
          size="large"
          color={COLORS.primary}
        />
      ) : (
        <FlatList
          data={budgets}
          keyExtractor={(item) =>
            item.id?.toString() ?? Math.random().toString()
          }
          renderItem={renderItem}
          contentContainerStyle={{ paddingBottom: 50 }}
          refreshing={loading}
          onRefresh={loadBudgets}
        />
      )}
    </View>
  );
};

export default Budgets;