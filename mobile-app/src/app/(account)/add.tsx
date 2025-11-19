import { View, Text } from "react-native";
import styles from "@/styles/styles";
import { useNavigation } from "expo-router";
import { useEffect } from "react";
import AccountForm from "@/components/account-form";

const AddAccount = () => {
	return (
		<View style={styles.container}>
			<Text style={styles.title}>Add Account</Text>
			<AccountForm />
		</View>
	);
};

export default AddAccount;