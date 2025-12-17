// app/(drawer)/logout.tsx

import { useEffect } from "react";
import {
  View,
  Text,
  ActivityIndicator,
} from "react-native";

import { useRouter } from "expo-router";
import { useAuth } from "@/contexts/auth-context";

import { useAppColors } from "@/hooks/use-app-colors";

export default function LogoutScreen() {
  const COLORS = useAppColors();
  const { logout } = useAuth();
  const router = useRouter();

  useEffect(() => {
    logout();
    router.replace("/(auth)/login");
  }, []);

  return (
    <View
      style={{
        flex: 1,
        justifyContent: "center",
        alignItems: "center",
      }}
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
