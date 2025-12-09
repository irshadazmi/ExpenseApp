import { View, Text, Pressable } from "react-native";
import { useRouter } from "expo-router";

import { useStyles } from "@/styles/styles";
import { useAppColors } from "@/hooks/use-app-colors";

import AccountForm from "@/components/account-form";

const AddAccount = () => {
  const styles = useStyles();
  const COLORS = useAppColors();
  const router = useRouter();

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
          Add Account
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

      <AccountForm />
    </View>
  );
};

export default AddAccount;
