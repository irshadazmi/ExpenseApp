// src/app/_layout.tsx
import { useEffect, useState } from "react";
import {
  router,
  Slot,
  Stack,
  usePathname,
} from "expo-router";

import {
  View,
  Pressable,
  Text,
  StatusBar,
} from "react-native";

import { SafeAreaView } from "react-native-safe-area-context";
import {
  DarkTheme,
  DefaultTheme,
  ThemeProvider,
} from "@react-navigation/native";

import MaterialIcons from "@expo/vector-icons/MaterialIcons";

import { IconSymbol } from "@/components/ui/icon-symbol";
import TabBar from "@/components/tab-bar";
import CustomDrawer from "@/components/custom-drawer";
import Loading from "./(auth)/loading";

import { AuthProvider, useAuth } from "@/contexts/auth-context";
import { useTheme } from "@/contexts/theme-context";

import {
  ThemeProvider as AppThemeProvider,
} from "@/contexts/theme-context";

import AsyncStorage from "@react-native-async-storage/async-storage";

import { DRAWER_ITEMS } from "@/constants/DRAWER_ITEMS";
import { PUBLIC_ROUTES } from "@/constants/PUBLIC_ROUTES";

import { useAppColors } from "@/hooks/use-app-colors";

/* ======================================================
    ROOT PROVIDERS
====================================================== */

export default function RootLayout() {
  return (
    <AuthProvider>
      <AppThemeProvider>
        <RootLayoutContent />
      </AppThemeProvider>
    </AuthProvider>
  );
}

/* ======================================================
    MAIN LAYOUT
====================================================== */

function RootLayoutContent() {
  const pathname = usePathname();
  const { user, loading } = useAuth();
  const { mode, resolvedMode, toggle } = useTheme();

  // ✅ NEW: unified color hook
  const COLORS = useAppColors();

  const [drawerVisible, setDrawerVisible] = useState(false);
  const [title, setTitle] = useState("DASHBOARD");

  const [introChecked, setIntroChecked] = useState(false);
  const [hasSeenIntro, setHasSeenIntro] = useState(false);

  /* ======================================================
      INTRO / ROUTE GUARDS
  ====================================================== */

  useEffect(() => {
    (async () => {
      const flag = await AsyncStorage.getItem("hasSeenIntro");
      setHasSeenIntro(flag === "true");
      setIntroChecked(true);
    })();
  }, []);

  useEffect(() => {
    if (!introChecked) return;

    if (hasSeenIntro === false) {
      router.replace("/intro/first_screen");
    }
  }, [introChecked, hasSeenIntro]);

  // Auth Guard
  useEffect(() => {
    if (loading) return;

    const isPublic = PUBLIC_ROUTES.some(
      (route) =>
        pathname === route || pathname.startsWith(route + "/")
    );

    if (!user && !isPublic) {
      router.replace("/(auth)/login");
    }
  }, [pathname, user, loading]);

  // Header Title
  useEffect(() => {
    const folder = pathname.split("/")[1] || "(dashboard)";

    const matched = DRAWER_ITEMS.find(
      (i) => i.name === folder
    );

    if (matched) setTitle(matched.title.toUpperCase());
  }, [pathname]);

  /* ======================================================
      LOADING
  ====================================================== */

  if (loading || !introChecked) {
    return <Loading />;
  }

  /* ======================================================
      PUBLIC ROUTES (Auth Layout)
  ====================================================== */

  if (!user) {
    return (
      <ThemeProvider
        value={resolvedMode === "dark" ? DarkTheme : DefaultTheme}
      >
        <Stack screenOptions={{ headerShown: false }}>
          <Stack.Screen name="(auth)" />
        </Stack>

        <StatusBar
          barStyle={
            resolvedMode === "dark"
              ? "light-content"
              : "dark-content"
          }
          backgroundColor={COLORS.background}
        />
      </ThemeProvider>
    );
  }

  /* ======================================================
      APP LAYOUT
  ====================================================== */

  return (
    <ThemeProvider
      value={resolvedMode === "dark" ? DarkTheme : DefaultTheme}
    >
      <SafeAreaView
        style={{
          flex: 1,
          backgroundColor: COLORS.background,
        }}
      >
        {/* ================= HEADER ================= */}

        <View
          style={{
            height: 72,
            backgroundColor: COLORS.primary,
            flexDirection: "row",
            alignItems: "center",
            paddingHorizontal: 16,
          }}
        >
          {/* Title */}
          <Text
            style={{
              flex: 1,
              color: COLORS.textInverse,
              fontSize: 18,
              fontWeight: "700",
            }}
          >
            {title}
          </Text>

          {/* Theme Toggle */}
          <Pressable
            onPress={toggle}
            style={{ padding: 8, marginRight: 8 }}
          >
            <MaterialIcons
              name={
                mode === "light"
                  ? "light-mode"
                  : mode === "dark"
                  ? "dark-mode"
                  : "settings"
              }
              size={26}
              color={COLORS.textInverse}
            />
          </Pressable>

          {/* Logout */}
          <Pressable
            onPress={() => router.replace("/logout")}
            style={{ padding: 8 }}
          >
            <IconSymbol
              name="arrow.right.square.fill"
              color={COLORS.textInverse}
              size={28}
            />
          </Pressable>
        </View>

        {/* ================= CONTENT ================= */}
        <View style={{ flex: 1 }}>
          <Slot />
        </View>

        {/* ================= TAB BAR ================= */}
        <TabBar onMenuPress={() => setDrawerVisible(true)} setTitle={setTitle} />

        {/* ================= DRAWER ================= */}
        <CustomDrawer
          visible={drawerVisible}
          onClose={() => setDrawerVisible(false)}
          setTitle={setTitle}
        />
      </SafeAreaView>

      {/* ================= STATUS BAR ================= */}
      <StatusBar
        barStyle={
          resolvedMode === "dark"
            ? "light-content"
            : "dark-content"
        }
        backgroundColor={COLORS.background}
      />
    </ThemeProvider>
  );
}