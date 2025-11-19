import React, { useEffect, useState } from "react";
import {
  View,
  Text,
  FlatList,
  Pressable,
  ActivityIndicator,
} from "react-native";
import styles from "@/styles/styles";
import { expenseService } from "@/services/expense-service";
import { COLORS } from "@/constants/COLORS";
import MaterialIcons from "@expo/vector-icons/MaterialIcons";
import { ExpenseResponse } from "@/types/expense";
import { RelativePathString, useNavigation, useRouter } from "expo-router";

const Expenses = () => {
  const [categories, setExpenses] = useState<ExpenseResponse[]>([]);
  const [loading, setLoading] = useState(false);
  const router = useRouter();
  const navigation = useNavigation();

  const loadExpenses = async () => {
    console.log("Loading expenses");
    try {
      setLoading(true);
      const res = await expenseService.getAll(0, 100);
      console.log(res);
      setExpenses(res);
    } catch (err) {
      console.log("Failed to load categories", err);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    navigation.setOptions({
      title: 'Expenses',
    });

    loadExpenses();
  }, [navigation]);

  // Go to Add Expense page (correct route path without parentheses)
  const handleAddExpense = () => {
    router.push('/(expenses)/add' as RelativePathString);
  };

  // Go to Edit/View Expense page (correct route path without parentheses)
  const handleEdit = (exp: ExpenseResponse) => {
    if (exp.id !== undefined) {
      router.push(`/(expenses)/${exp.id}` as RelativePathString);
    } else {
      console.error("Expense ID is undefined");
    }
  };

  // Delete expense
  const handleDelete = async (exp: ExpenseResponse) => {
    if (exp.id !== undefined) {
      try {
        await expenseService.delete(exp.id);
        await loadExpenses();
      } catch (err) {
        console.log("Failed to delete expense", err);
      }
    }
  };

  const renderItem = ({ item, index }: { item: ExpenseResponse; index: number }) => (
    <View style={[
      styles.listRow,
      index % 2 === 1 && styles.listRowAlt, // alternate rows
    ]}>
      {/* Category */}
      <View style={{ flex: 1 }}>
        <Text style={{ fontSize: 16, color: COLORS.text }}>{item.category_id}</Text>
      </View>
      {/* Description */}
      <View style={{ flex: 2 }}>
        <Text style={{ fontSize: 16, color: COLORS.text }}>{item.description}</Text>
      </View>
      {/* Is Active */}
      <View style={{ flex: 1, alignItems: "center" }}>
        <Text style={{ fontSize: 16, color: COLORS.text }}>{item.amount}</Text>
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
        <Text style={[styles.title, { flex: 1 }]}>Expenses</Text>
        <Pressable style={styles.button} onPress={handleAddExpense}>
          <Text style={styles.buttonText}>Add Expense</Text>
        </Pressable>
      </View>

      {/* List header */}
      <View style={styles.listHeader}>
        <Text style={[styles.listHeaderText, { flex: 1, textAlign: "left" }]}>Category</Text>
        <Text style={[styles.listHeaderText, { flex: 2, textAlign: "center" }]}>Description</Text>
        <Text style={[styles.listHeaderText, { flex: 1, textAlign: "center" }]}>Amount</Text>
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
          data={categories}
          keyExtractor={item => item?.id?.toString() ?? ''}
          renderItem={renderItem}
          contentContainerStyle={{ paddingBottom: 16 }}
        />
      )}
    </View>
  );
};

export default Expenses;
