import { View, Text, ScrollView, Button } from "react-native";
import { useEffect, useState } from "react";
import { TransactionResponse } from "@/src/types/transaction";
import { transactionService } from "@/src/services/transaction-service";
import styles from "@/src/styles/styles";
import { useRouter } from "expo-router";

export default function Transactions() {
  const [transactions, setTransactions] = useState<TransactionResponse[]>([]);

  const router = useRouter();

  const currentUserId = 1;
  const isSuperAdmin = false;

  useEffect(() => {
    const loadTransactions = async () => {
      const data = isSuperAdmin
        ? await transactionService.getAll()
        : await transactionService.getByUser(currentUserId);

      setTransactions(data || []);
    };
    loadTransactions();
  }, []);

  const gotoDashboard = () => {
    router.replace("/(dashboard)");
  }

  return (
    <View style={styles.container}>
      <Text style={styles.title}>Transactions</Text>

      <ScrollView style={{ flex: 1 }}>
        {transactions.map((item) => (
          <View key={item.id} style={styles.card}>
            <Text style={styles.cardTitle}>{item.description}</Text>
            <Text style={styles.cardText}>Amount: ₹{item.amount}</Text>
            <Text style={styles.cardText}>Type: {item.type}</Text>
            <Text style={styles.cardText}>Transaction Date: {item.transaction_date}</Text>
          </View>
        ))}
        <Button title="Goto Dashboard" onPress={gotoDashboard}></Button>
      </ScrollView>
    </View>
  );
}