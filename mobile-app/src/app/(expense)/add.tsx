import ExpenseForm from "@/components/expense-form";
import styles from "@/styles/styles";
import { View, Text } from "react-native";

const AddExpense = () => {
	return (
		<View style={styles.container}>
			<Text style={styles.title}>Add Expense</Text>
			<ExpenseForm />
		</View>
	);
};

export default AddExpense;
