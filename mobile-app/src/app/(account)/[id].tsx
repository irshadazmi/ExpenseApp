import { View, Text } from "react-native";
import styles from "@/styles/styles";
import AccountForm from "@/components/account-form";
import { useLocalSearchParams, useNavigation } from "expo-router";
import { useEffect } from "react";

const EditAccount = () => {
  const { id } = useLocalSearchParams();
  // AccountForm expects a number for id
  const categoryId = id ? Number(id) : undefined;

  return (
    <View style={styles.container}>
      <Text style={styles.title}>Edit Account</Text>
      <AccountForm id={categoryId} />
    </View>
  );
};

export default EditAccount;
