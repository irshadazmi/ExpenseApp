// src/app/(drawer)/logout.tsx

import { useEffect } from "react";
import {
  ActivityIndicator,
  View,
  Text,
} from "react-native";

import { useRouter } from "expo-router";
import { useAuth } from "@/contexts/auth-context";

import { useStyles } from "@/styles/styles";
import { useAppColors } from "@/hooks/use-app-colors";

export default function LogoutScreen() {
  const styles = useStyles();
  const COLORS = useAppColors();
  const router = useRouter();
  const { logout } = useAuth();

  useEffect(() => {
    logout();
    router.replace("/(auth)/login");
  }, []);

  return (
    <View
      style={[
        styles.container,
        {
          justifyContent: "center",
          alignItems: "center",
        },
      ]}
    >
      <ActivityIndicator size="large" color={COLORS.primary} />

      <Text
        style={{
          marginTop: 12,
          fontSize: 16,
          color: COLORS.text,
        }}
      >
        Logging out...
      </Text>
    </View>
  );
}
