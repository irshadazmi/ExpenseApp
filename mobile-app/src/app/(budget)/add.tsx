import { View, Text } from "react-native";
import styles from "@/styles/styles";
import BudgetForm from "@/components/budget-form";

const AddBudget = () => {
	return (
		<View style={styles.container}>
			<Text style={styles.title}>Add Budget</Text>
			<BudgetForm />
		</View>
	);
};

export default AddBudget;