import React, { useEffect, useState } from "react";
import {
  View,
  Text,
  FlatList,
  Pressable,
  ActivityIndicator,
} from "react-native";
import styles from "@/styles/styles";
import { budgetService } from "@/services/budget-service";
import { COLORS } from "@/constants/COLORS";
import MaterialIcons from "@expo/vector-icons/MaterialIcons";
import { BudgetResponse } from "@/types/budget";
import { RelativePathString, useRouter } from "expo-router";

const Budgets = () => {
  const [budgets, setBudgets] = useState<BudgetResponse[]>([]);
  const [loading, setLoading] = useState(false);
  const router = useRouter();

  const loadBudgets = async () => {
    try {
      setLoading(true);
      const res = await budgetService.getAll(0, 100);
      console.log(res);
      setBudgets(res);
    } catch (err) {
      console.log("Failed to load budgets", err);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    loadBudgets();
  }, []);

  // Go to Add Budget page (correct route path without parentheses)
  const handleAddBudget = () => {
    router.push('/(budget)/add' as RelativePathString);
  };

  // Go to Edit/View Budget page (correct route path without parentheses)
  const handleEdit = (acc: BudgetResponse) => {
    if (acc.id !== undefined) {
      router.push(`/(budget)/${acc.id}` as RelativePathString);
    } else {
      console.error("Budget ID is undefined");
    }
  };

  // Delete budget
  const handleDelete = async (acc: BudgetResponse) => {
    if (acc.id !== undefined) {
      try {
        await budgetService.delete(acc.id);
        await loadBudgets();
      } catch (err) {
        console.log("Failed to delete budget", err);
      }
    }
  };

  const renderItem = ({ item, index }: { item: BudgetResponse; index: number }) => (
    <View style={[
      styles.listRow,
      index % 2 === 1 && styles.listRowAlt, // alternate rows
    ]}>
      {/* Name */}
      <View style={{ flex: 2 }}>
        <Text style={{ fontSize: 16, color: COLORS.text }}>{item.name}</Text>
      </View>
      {/* Is Active */}
      <View style={{ flex: 1, alignItems: "center" }}>
        <Text style={{ color: item.is_active ? "green" : "red" }}>
          {item.is_active ? "Active" : "Inactive"}
        </Text>
      </View>
      {/* Actions */}
      <View style={{
        flex: 1,
        flexDirection: "row",
        justifyContent: "flex-end",
        gap: 12,
      }}>
        <Pressable onPress={() => handleEdit(item)}>
          <MaterialIcons name="edit" size={22} color={COLORS.primary} />
        </Pressable>
        <Pressable onPress={() => handleDelete(item)}>
          <MaterialIcons name="delete" size={22} color={COLORS.danger} />
        </Pressable>
      </View>
    </View>
  );

  return (
    <View style={[styles.container, { paddingHorizontal: 16 }]}>
      {/* Header row: title + Add button */}
      <View style={{
        flexDirection: "row",
        alignItems: "center",
        marginBottom: 16,
      }}>
        <Text style={[styles.title, { flex: 1 }]}>Budgets</Text>
        <Pressable style={styles.button} onPress={handleAddBudget}>
          <Text style={styles.buttonText}>Add Budget</Text>
        </Pressable>
      </View>

      {/* List header */}
      <View style={styles.listHeader}>
        <Text style={[styles.listHeaderText, { flex: 2, textAlign: "left" }]}>Name</Text>
        <Text style={[styles.listHeaderText, { flex: 1, textAlign: "center" }]}>Active</Text>
        <Text style={[styles.listHeaderText, { flex: 1, textAlign: "right" }]}>Action</Text>
      </View>

      {loading ? (
        <ActivityIndicator
          style={{ marginTop: 16 }}
          size="small"
          color={COLORS.primary}
        />
      ) : (
        <FlatList
          data={budgets}
          keyExtractor={item => item?.id?.toString() ?? ''}
          renderItem={renderItem}
          contentContainerStyle={{ paddingBottom: 16 }}
        />
      )}
    </View>
  );
};

export default Budgets;
