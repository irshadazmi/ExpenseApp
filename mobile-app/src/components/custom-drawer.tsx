// mobile-app/src/components/custom-drawer.tsx
import React from "react";
import { View, Text, Pressable, ScrollView } from "react-native";
import { RelativePathString, useRouter, useSegments } from "expo-router";

import { DRAWER_ITEMS } from "@/constants/DRAWER_ITEMS";
import { useStyles } from "@/styles/styles";
import { useAuth } from "@/contexts/auth-context";
import { useAppColors } from "@/hooks/use-app-colors";
import { IconSymbol } from "@/components/ui/icon-symbol";
import { authService } from "@/services/auth-service";

type Props = {
  onClose?: () => void;
};

const CustomDrawer: React.FC<Props> = ({ onClose }) => {
  const styles = useStyles();
  const COLORS = useAppColors();
  const router = useRouter();
  const segments = useSegments();
  const { logout } = useAuth();

  /** ✅ SINGLE SOURCE OF TRUTH */
  const activeGroup = React.useMemo(() => {
    const seg0 = segments[0]; // "(dashboard)"
    return seg0 ? seg0.replace(/[()]/g, "") : "dashboard";
  }, [segments]);

  const handleNavigate = async (name: string) => {
    if (name === "logout") {
      await logout();
      router.replace("/(auth)/login");
      onClose?.();
      return;
    }

    if (name === "(auth)/register") {
      try {
        const me = await authService.getCurrentUser() as any;

        // 🔴 IMPORTANT: log once to verify shape
        console.log("UserID:", me.user.id);

        router.push({
          pathname: "/(auth)/register",
          params: {
            user_id: me.user, // <-- important
          },
        });

        onClose?.(); // ✅ close only after navigation
      } catch (e) {
        console.error("Failed to load user profile", e);
        // ❌ do NOT close drawer here
      }
      return;
    }

    router.push(`/${name}` as RelativePathString);
    onClose?.();
  };

  return (
    <View style={styles.drawer}>
      {/* BACKDROP */}
      <Pressable style={styles.backdrop} onPress={onClose} />

      {/* DRAWER */}
      <View style={styles.drawerContainer}>
        <ScrollView contentContainerStyle={{ paddingBottom: 24 }}>
          {DRAWER_ITEMS.map((item) => {
            if (item.name === "logout") {
              return (
                <Pressable
                  key="logout"
                  style={styles.drawerItem}
                  onPress={() => handleNavigate("logout")}
                >
                  <IconSymbol
                    name={item.icon as any}
                    size={20}
                    color={COLORS.textMuted}
                  />
                  <Text style={styles.drawerItemText}>
                    {item.title}
                  </Text>
                </Pressable>
              );
            }

            const group = item.name.replace(/[()]/g, "");
            const isActive = group === activeGroup;

            return (
              <Pressable
                key={item.name}
                style={[
                  styles.drawerItem,
                  isActive && styles.drawerItemActive,
                ]}
                onPress={() => handleNavigate(item.name)}
              >
                <IconSymbol
                  name={item.icon as any}
                  size={20}
                  color={isActive ? COLORS.tabActive : COLORS.textMuted}
                />

                <Text
                  style={[
                    styles.drawerItemText,
                    isActive && styles.drawerItemTextActive,
                  ]}
                >
                  {item.title}
                </Text>
              </Pressable>
            );
          })}
        </ScrollView>
      </View>
    </View>
  );
};

export default CustomDrawer;
