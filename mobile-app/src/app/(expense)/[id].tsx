import { View, Text } from "react-native";
import styles from "@/styles/styles";
import { useLocalSearchParams } from "expo-router";
import ExpenseForm from "@/components/expense-form";

const EditExpense = () => {
  const { id } = useLocalSearchParams();
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
