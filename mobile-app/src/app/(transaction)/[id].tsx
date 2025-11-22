import { View, Text } from "react-native";
import styles from "@/styles/styles";
import { useLocalSearchParams } from "expo-router";
import TransactionForm from "@/components/transaction-form";

const EditTransaction = () => {
  const { id } = useLocalSearchParams();
  // TransactionForm expects a number for id
  const transactionId = id ? Number(id) : undefined;

  return (
    <View style={styles.container}>
      <Text style={styles.title}>Edit Transaction</Text>
      <TransactionForm id={transactionId} />
    </View>
  );
};

export default EditTransaction;
