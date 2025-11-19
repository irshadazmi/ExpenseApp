import { View, Text } from "react-native";
import styles from "@/styles/styles";
import { useNavigation } from "expo-router";
import { useEffect } from "react";
import BudgetForm from "@/components/budget-form";

const AddBudget = () => {
	const navigation = useNavigation();
	useEffect(() => {
		navigation.setOptions({ title: "Add Budget" });
	}, [navigation]);

	return (
		<View style={styles.container}>
			<Text style={styles.title}>Add Budget</Text>
			<BudgetForm />
		</View>
	);
};

export default AddBudget;