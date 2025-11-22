import TransactionForm from "@/components/transaction-form";
import styles from "@/styles/styles";
import { View, Text } from "react-native";

const AddTransaction = () => {
	return (
		<View style={styles.container}>
			<Text style={styles.title}>Add Transaction</Text>
			<TransactionForm />
		</View>
	);
};

export default AddTransaction;
