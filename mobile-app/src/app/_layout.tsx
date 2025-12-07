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

import TabBar from "@/components/tab-bar";
import CustomDrawer from "@/components/custom-drawer";
import MaterialIcons from "@expo/vector-icons/MaterialIcons";
import { IconSymbol } from "@/components/ui/icon-symbol";
import { AuthProvider, useAuth } from "@/contexts/auth-context";
import AsyncStorage from "@react-native-async-storage/async-storage";
import { useTheme } from "@/contexts/theme-context";

import Loading from "./(auth)/loading";

import {
  DarkTheme,
  DefaultTheme,
  ThemeProvider,
} from "@react-navigation/native";

import { DRAWER_ITEMS } from "@/constants/DRAWER_ITEMS";
import { PUBLIC_ROUTES } from "@/constants/PUBLIC_ROUTES";

/* ✅ Wrap with AppThemeProvider */
import {
  ThemeProvider as AppThemeProvider,
} from "@/contexts/theme-context";

export default function RootLayout() {
  return (
    <AuthProvider>
      <AppThemeProvider>
        <RootLayoutContent />
      </AppThemeProvider>
    </AuthProvider>
  );
}

function RootLayoutContent() {
  const pathname = usePathname();
  const { user, loading } = useAuth();
  const { mode, resolvedMode, toggle } = useTheme(); // ✅ use theme context

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

  // Auth guard
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

  // Header title
  useEffect(() => {
    const folder = pathname.split("/")[1] || "dashboard";
    const matched = DRAWER_ITEMS.find((i) => i.name === folder);
    if (matched) setTitle(matched.title.toUpperCase());
  }, [pathname]);

  /* ======================================================
      LOADING
  ====================================================== */
  if (loading || !introChecked) {
    return <Loading />;
  }

  /* ======================================================
      PUBLIC ROUTES
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
          barStyle={resolvedMode === "dark" ? "light-content" : "dark-content"}
          backgroundColor={resolvedMode === "dark" ? "#151718" : "#FFFFFF"}
        />
      </ThemeProvider>
    );
  }

  /* ======================================================
      MAIN APP LAYOUT
  ====================================================== */
  return (
    <ThemeProvider
      value={resolvedMode === "dark" ? DarkTheme : DefaultTheme}
    >
      <SafeAreaView
        style={{
          flex: 1,
          backgroundColor: resolvedMode === "dark" ? "#151718" : "#FFFFFF",
        }}
      >
        {/* ================= HEADER ================= */}
        <View
          style={{
            height: 72,
            backgroundColor: resolvedMode === "dark" ? "#9D7BFF" : "#7F00FF",
            flexDirection: "row",
            alignItems: "center",
            paddingHorizontal: 16,
          }}
        >
          {/* Title */}
          <Text
            style={{
              flex: 1,
              color: "#fff",
              fontSize: 18,
              fontWeight: "700",
            }}
          >
            {title}
          </Text>

          {/* Theme Toggle */}
          <Pressable onPress={toggle} style={{ padding: 8, marginRight: 8 }}>
            <MaterialIcons
              name={
                mode === "light"
                  ? "light-mode"
                  : mode === "dark"
                  ? "dark-mode"
                  : "settings"
              }
              size={26}
              color="#fff"
            />
          </Pressable>

          {/* Logout */}
          <Pressable
            onPress={() => router.replace("/logout")}
            style={{ padding: 8 }}
          >
            <IconSymbol
              name="arrow.right.square.fill"
              color="#fff"
              size={28}
            />
          </Pressable>
        </View>

        {/* ================= CONTENT ================= */}
        <View style={{ flex: 1 }}>
          <Slot />
        </View>

        {/* ================= TAB BAR ================= */}
        <TabBar onMenuPress={() => setDrawerVisible(true)} />

        {/* ================= DRAWER ================= */}
        <CustomDrawer
          visible={drawerVisible}
          onClose={() => setDrawerVisible(false)}
          setTitle={setTitle}
        />
      </SafeAreaView>

      {/* ================= STATUS BAR ================= */}
      <StatusBar
        barStyle={resolvedMode === "dark" ? "light-content" : "dark-content"}
        backgroundColor={resolvedMode === "dark" ? "#151718" : "#FFFFFF"}
      />
    </ThemeProvider>
  );
}