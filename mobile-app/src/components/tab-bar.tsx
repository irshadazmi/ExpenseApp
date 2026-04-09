// src/components/tab-bar.tsx

import { View, Pressable, Text } from "react-native";
import { useRouter, useSegments, Route } from "expo-router";
import { TAB_ITEMS } from "@/constants/TAB_ITEMS";
import { IconSymbol } from "@/components/ui/icon-symbol";
import { useStyles } from "@/styles/styles";
import type { SFSymbol } from "expo-symbols";
import { LinearGradient } from "expo-linear-gradient";
import { useAppColors } from "@/hooks/use-app-colors";

type TabBarProps = {
  onMenuPress?: () => void;
  setTitle: (title: string) => void;
};

export default function TabBar({ onMenuPress, setTitle }: TabBarProps) {
  const styles = useStyles();
  const COLORS = useAppColors();

  const router = useRouter();
  const segments = useSegments();

  // let currentTabKey: string = 'dashboard';
  // if (segments.length > 0) {
  //   const first = segments[0];
  //   currentTabKey = first;
  // } else {
  //   currentTabKey = 'dashboard';
  // }

  // Root segment -> selected tab
  const currentTabKey: string = segments[0] || "(dashboard)";

  return (
    <LinearGradient
      colors={[COLORS.tabBg, COLORS.primary]}
      start={{ x: 0, y: 0 }}
      end={{ x: 0, y: 1 }}
      style={[
        styles.tabBarContainer,
        {
          position: "absolute",
          bottom: 0,
          left: 0,
          right: 0,
          height: 64,
          zIndex: 10,
          backgroundColor: COLORS.tabBg, 
        },
      ]}
    >
      {TAB_ITEMS.map((item) => {
        const routePath = `/${item.name}`;
        const isActive = currentTabKey === item.name;
        const badgeCount = item.badgeCount ?? 0;

        const handlePress = () => {
          if (item.name === "(menu)") {
            onMenuPress?.();
            return;
          }
          setTitle(item.title.toUpperCase());
          router.replace(routePath as Route);
        };

        return (
          <Pressable
            key={item.name}
            onPress={handlePress}
            style={styles.tabItem}
          >
            <View style={styles.tabIconWrapper}>
              <IconSymbol
                name={item.icon as SFSymbol}
                size={22}
                color={
                  isActive
                    ? COLORS.tabActive
                    : COLORS.tabInactive
                }
              />

              {badgeCount > 0 && (
                <View
                  style={[
                    styles.tabsBadgeContainer,
                    {
                      backgroundColor: COLORS.badgeBg,
                    },
                  ]}
                >
                  <Text
                    style={[
                      styles.tabsBadgeText,
                      {
                        color: COLORS.badgeText,
                      },
                    ]}
                  >
                    {badgeCount > 99 ? "99+" : badgeCount}
                  </Text>
                </View>
              )}
            </View>

            <Text
              style={[
                styles.tabLabel,
                {
                  color: isActive
                    ? COLORS.tabActive
                    : COLORS.tabInactive,
                  fontWeight: isActive ? "700" : "500",
                },
              ]}
            >
              {item.title}
            </Text>
          </Pressable>
        );
      })}
    </LinearGradient>
  );
}