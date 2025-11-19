import ExpenseForm from "@/components/expense-form";
import styles from "@/styles/styles";
import { useNavigation } from "expo-router";
import { useEffect } from "react";
import { View, Text } from "react-native";

const AddExpense = () => {
	const navigation = useNavigation();
	useEffect(() => {
		navigation.setOptions({ title: "Add Category" });
	}, [navigation]);

	return (
		<View style={styles.container}>
			<Text style={styles.title}>Add Expense</Text>
			<ExpenseForm />
		</View>
	);
};

export default AddExpense;
