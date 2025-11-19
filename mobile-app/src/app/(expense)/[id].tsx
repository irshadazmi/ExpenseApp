import React, { useEffect } from "react";
import { View, Text } from "react-native";
import styles from "@/styles/styles";
import { useNavigation, useLocalSearchParams } from "expo-router";
import ExpenseForm from "@/components/expense-form";

const EditExpense = () => {
  const navigation = useNavigation();
  const { id } = useLocalSearchParams();

  useEffect(() => {
    navigation.setOptions({ title: "Edit Expense" });
  }, [navigation]);

  // ExpenseForm expects a number for id
  const expenseId = id ? Number(id) : undefined;

  return (
    <View style={styles.container}>
      <Text style={styles.title}>Edit Expense</Text>
      <ExpenseForm id={expenseId} />
    </View>
  );
};

export default EditExpense;
