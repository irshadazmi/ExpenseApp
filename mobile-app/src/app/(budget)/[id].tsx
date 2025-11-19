import { View, Text } from "react-native";
import styles from "@/styles/styles";
import BudgetForm from "@/components/budget-form";
import { useLocalSearchParams, useNavigation } from "expo-router";
import { useEffect } from "react";

const EditBudget = () => {
	const navigation = useNavigation();
  const { id } = useLocalSearchParams();

  useEffect(() => {
    navigation.setOptions({ title: "Edit Budget" });
  }, [navigation]);

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
