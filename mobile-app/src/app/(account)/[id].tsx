import { View, Text, Pressable } from "react-native";
import { useRouter, useLocalSearchParams } from "expo-router";

import { useStyles } from "@/styles/styles";
import { useAppColors } from "@/hooks/use-app-colors";

import AccountForm from "@/components/account-form";

const EditAccount = () => {
  const styles = useStyles();
  const COLORS = useAppColors();
  const router = useRouter();
  const { id } = useLocalSearchParams();

  // ✅ Ensure proper number conversion
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
            {
              flex: 1,
              textAlign: "left",
              marginBottom: 0,
            },
          ]}
        >
          Edit Account
        </Text>

        <Pressable onPress={() => router.back()}>
          <Text
            style={{
              color: COLORS.primary,
              fontSize: 14,
              fontWeight: "700",
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
