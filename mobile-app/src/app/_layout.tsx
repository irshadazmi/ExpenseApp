// mobile-app/src/app/_layout.tsx
import React, { useEffect, useMemo, useState } from "react";
import { View, ActivityIndicator, StyleSheet } from "react-native";
import { Slot, useRouter, useSegments } from "expo-router";
import { GestureHandlerRootView } from "react-native-gesture-handler";
import {
  SafeAreaProvider,
  SafeAreaView,
} from "react-native-safe-area-context";

import { AuthProvider, useAuth } from "@/contexts/auth-context";
import { ThemeProvider } from "@/contexts/theme-context";
import { useStyles } from "@/styles/styles";
import { useAppColors } from "@/hooks/use-app-colors";

import AppHeader from "@/components/ui/app-header";
import TabBar from "@/components/tab-bar";
import CustomDrawer from "@/components/custom-drawer";

import { TAB_ITEMS } from "@/constants/TAB_ITEMS";
import { DRAWER_ITEMS } from "@/constants/DRAWER_ITEMS";

/* ======================================================
   APP SHELL
====================================================== */

function AppShell() {
  const styles = useStyles();
  const COLORS = useAppColors();

  const { isLoading, isAuthenticated } = useAuth();
  const router = useRouter();
  const segments = useSegments(); // ✅ IMPORTANT

  const [drawerOpen, setDrawerOpen] = useState(false);

  const isAuthRoute = segments[0] === "(auth)";

  /* ======================================================
     TITLE MAP (Tabs + Drawer)
  ====================================================== */

  const TITLE_MAP = useMemo(() => {
    const map: Record<string, string> = {};
    [...TAB_ITEMS, ...DRAWER_ITEMS].forEach((item) => {
      const key = item.name.replace(/[()]/g, "");
      map[key] = item.title.toUpperCase();
    });
    return map;
  }, []);

  /* ======================================================
     ACTIVE GROUP (CORRECT)
  ====================================================== */

  const activeGroup = useMemo(() => {
    const seg0 = segments[0]; // e.g. "(dashboard)"
    return seg0 ? seg0.replace(/[()]/g, "") : "dashboard";
  }, [segments]);

  const headerTitle = TITLE_MAP[activeGroup] ?? "DANTIFY";

  /* ======================================================
     AUTH GUARD
  ====================================================== */

  useEffect(() => {
    if (isLoading) return;

    if (!isAuthenticated && !isAuthRoute) {
      router.replace("/(auth)/login");
      return;
    }

    if (isAuthenticated && isAuthRoute) {
      router.replace("/(dashboard)");
    }
  }, [isAuthenticated, isLoading, isAuthRoute]);

  /* ======================================================
     LOADING
  ====================================================== */

  if (isLoading) {
    return (
      <SafeAreaView
        style={[
          styles.container,
          { backgroundColor: COLORS.background },
        ]}
      >
        <View style={stylesLoader.center}>
          <ActivityIndicator size="large" color={COLORS.primary} />
        </View>
      </SafeAreaView>
    );
  }

  /* ======================================================
     AUTH ROUTES (NO CHROME)
  ====================================================== */

  if (!isAuthenticated) {
    return (
      <SafeAreaView
        style={{ flex: 1, backgroundColor: COLORS.background }}
        edges={["top", "bottom"]}
      >
        <GestureHandlerRootView style={{ flex: 1 }}>
          <Slot />
        </GestureHandlerRootView>
      </SafeAreaView>
    );
  }

  /* ======================================================
     APP ROUTES (WITH CHROME)
  ====================================================== */

  return (
    <SafeAreaView
      style={{ flex: 1, backgroundColor: COLORS.background }}
      edges={["top", "bottom"]}
    >
      <GestureHandlerRootView style={{ flex: 1 }}>
        <View style={{ flex: 1, backgroundColor: COLORS.background }}>
          {/* HEADER */}
          <AppHeader title={headerTitle} />

          {/* CONTENT */}
          <View style={{ flex: 1 }}>
            <Slot />
          </View>

          {/* TAB BAR */}
          <TabBar onMenuPress={() => setDrawerOpen(true)} />
        </View>

        {/* DRAWER */}
        {drawerOpen && (
          <View style={StyleSheet.absoluteFill}>
            <CustomDrawer onClose={() => setDrawerOpen(false)} />
          </View>
        )}
      </GestureHandlerRootView>
    </SafeAreaView>
  );
}

/* ======================================================
   ROOT
====================================================== */

export default function RootLayout() {
  return (
    <AuthProvider>
      <ThemeProvider>
        <SafeAreaProvider>
          <AppShell />
        </SafeAreaProvider>
      </ThemeProvider>
    </AuthProvider>
  );
}

const stylesLoader = StyleSheet.create({
  center: {
    flex: 1,
    justifyContent: "center",
    alignItems: "center",
  },
});
