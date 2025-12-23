// src/components/app-header.tsx

import React from "react";
import { View, Text, Pressable } from "react-native";
import { useRouter } from "expo-router";
import Ionicons from "@expo/vector-icons/Ionicons";

import { useStyles } from "@/styles/styles";
import { useTheme } from "@/contexts/theme-context";
import { useAuth } from "@/contexts/auth-context";
import { useAppColors } from "@/hooks/use-app-colors";

type Props = {
  title: string;
};

const AppHeader: React.FC<Props> = ({ title }) => {
  const styles = useStyles();
  const COLORS = useAppColors();
  const router = useRouter();

  const { mode, resolvedMode, setMode } = useTheme();
  const { logout } = useAuth();

  /* ---------- THEME TOGGLE ---------- */
  const handleThemePress = () => {
    const next =
      mode === "system"
        ? "light"
        : mode === "light"
        ? "dark"
        : "system";
    setMode(next);
  };

  const themeIcon =
    mode === "system"
      ? "contrast-outline"
      : resolvedMode === "dark"
      ? "moon-outline"
      : "sunny-outline";

  /* ---------- LOGOUT ---------- */
  const handleLogout = async () => {
    await logout();
    router.replace("/(auth)/login");
  };

  return (
    <View
      style={[
        styles.headerContainer,
        {
          backgroundColor: COLORS.primary,
          flexDirection: "row",
          alignItems: "center",
          justifyContent: "space-between",
          paddingHorizontal: 16,
        },
      ]}
    >
      {/* LEFT: Title (always left aligned) */}
      <Text
        style={[styles.headerText, { color: COLORS.textInverse }]}
        numberOfLines={1}
      >
        {title}
      </Text>

      {/* RIGHT: Actions */}
      <View style={{ flexDirection: "row", alignItems: "center" }}>
        <Pressable onPress={handleThemePress} style={{ marginRight: 12 }}>
          <Ionicons name={themeIcon} size={22} color={COLORS.textInverse} />
        </Pressable>

        <Pressable onPress={handleLogout}>
          <Ionicons name="log-out-outline" size={22} color={COLORS.textInverse} />
        </Pressable>
      </View>
    </View>
  );
};

export default AppHeader;
