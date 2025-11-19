import { View, Text } from "react-native";
import styles from "@/styles/styles";
import BudgetForm from "@/components/budget-form";
import { useLocalSearchParams } from "expo-router";

const EditBudget = () => {
  const { id } = useLocalSearchParams();
  // BudgetForm expects a number for id
  const categoryId = id ? Number(id) : undefined;

  return (
    <View style={styles.container}>
      <Text style={styles.title}>Edit Budget</Text>
      <BudgetForm id={categoryId} />
    </View>
  );
};

export default EditBudget;
