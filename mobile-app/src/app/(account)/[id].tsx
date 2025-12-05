import { View, Text, Pressable } from "react-native";
import { useRouter, useLocalSearchParams } from "expo-router";

import styles from "@/styles/styles";
import { COLORS } from "@/constants/COLORS";
import AccountForm from "@/components/account-form";

const EditAccount = () => {
  const router = useRouter();
  const { id } = useLocalSearchParams();

  // Ensure proper number conversion for AccountForm
  const accountId = id ? Number(id) : undefined;

  return (
    <View style={styles.container}>

      {/* Header: Title + Back */}
      <View
        style={{
          flexDirection: "row",
          alignItems: "center",
          marginBottom: 16,
        }}
      >
        <Text
          style={[
            styles.title,
            { flex: 1, textAlign: "left", marginBottom: 0 },
          ]}
        >
          Edit Account
        </Text>

        <Pressable onPress={() => router.back()}>
          <Text
            style={{
              color: COLORS.primary,
              fontSize: 14,
              fontWeight: "600",
            }}
          >
            Back to List
          </Text>
        </Pressable>
      </View>

      <AccountForm id={accountId} />
    </View>
  );
};

export default EditAccount;
