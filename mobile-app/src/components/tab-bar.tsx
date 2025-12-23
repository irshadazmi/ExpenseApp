// mobile-app/src/components/tab-bar.tsx
import React from "react";
import { View, Text, Pressable } from "react-native";
import { RelativePathString, useRouter, useSegments } from "expo-router";

import { TAB_ITEMS } from "@/constants/TAB_ITEMS";
import { useStyles } from "@/styles/styles";
import { useAppColors } from "@/hooks/use-app-colors";
import { IconSymbol } from "@/components/ui/icon-symbol";

type Props = {
  onMenuPress?: () => void;
};

const TabBar: React.FC<Props> = ({ onMenuPress }) => {
  const styles = useStyles();
  const COLORS = useAppColors();
  const router = useRouter();
  const segments = useSegments();

  /** ✅ SINGLE SOURCE OF TRUTH */
  const activeGroup = React.useMemo(() => {
    const seg0 = segments[0]; // "(dashboard)"
    return seg0 ? seg0.replace(/[()]/g, "") : "dashboard";
  }, [segments]);

  const handlePress = (name: string) => {
    if (name === "(menu)") {
      onMenuPress?.();
      return;
    }
    router.push(`/${name}` as RelativePathString);
  };

  return (
    <View style={styles.tabBarContainer}>
      {TAB_ITEMS.map((item) => {
        const group = item.name.replace(/[()]/g, "");
        const isActive =
          item.name !== "(menu)" && group === activeGroup;

        const color = isActive
          ? COLORS.tabActive
          : COLORS.tabInactive;

        return (
          <Pressable
            key={item.name}
            style={styles.tabItem}
            onPress={() => handlePress(item.name)}
          >
            <View style={styles.tabIconWrapper}>
              <IconSymbol
                name={item.icon as any}
                size={22}
                color={color}
              />

              {item.badgeCount > 0 && item.name !== "(menu)" && (
                <View
                  style={[
                    styles.tabsBadgeContainer,
                    { backgroundColor: COLORS.badgeBg },
                  ]}
                >
                  <Text
                    style={[
                      styles.tabsBadgeText,
                      { color: COLORS.badgeText },
                    ]}
                  >
                    {item.badgeCount > 9 ? "9+" : item.badgeCount}
                  </Text>
                </View>
              )}
            </View>

            <Text
              style={[
                styles.tabLabel,
                {
                  color,
                  fontWeight: isActive ? "600" : "400",
                },
              ]}
            >
              {item.title}
            </Text>
          </Pressable>
        );
      })}
    </View>
  );
};

export default TabBar;
