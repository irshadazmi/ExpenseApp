// src/components/TabBar.tsx

import { View, Pressable, Text } from 'react-native';
import { useRouter, useSegments, Route } from 'expo-router';
import { TAB_ITEMS } from '@/constants/TAB_ITEMS';
import { COLORS } from '@/constants/COLORS';
import { IconSymbol } from '@/components/ui/icon-symbol';
import styles from '@/styles/styles';
import type { SFSymbol } from 'expo-symbols';
import { LinearGradient } from 'expo-linear-gradient';

type TabBarProps = {
  onMenuPress?: () => void; // ✅ Callback for Menu tab
};

export default function TabBar({ onMenuPress }: TabBarProps) {
  const router = useRouter();
  const segments = useSegments(); // gets [...segments] from the current path

  // Determine active tab
  // Example:
  // []                → dashboard
  // ["(budget)"]      → (budget)
  // ["(transaction)"] → (transaction)
  let currentTabKey: string = segments[0] || 'dashboard';

  return (
    <LinearGradient
      colors={['#2B123D', COLORS.tabBg]}
      start={{ x: 0, y: 0 }}
      end={{ x: 0, y: 1 }}
    >
      <View style={styles.tabBarContainer}>
        {TAB_ITEMS.map((item) => {
          const routePath = `/${item.name}`;
          const isActive = currentTabKey === item.name;
          const badgeCount = item.badgeCount ?? 0;

          const handlePress = () => {
            // ✅ Special behavior for Menu tab – open drawer instead of navigating
            if (item.name === '(menu)') {
              onMenuPress?.();
              return;
            }

            // ✅ Normal navigation for other tabs
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
                  <View style={styles.tabsBadgeContainer}>
                    <Text style={styles.tabsBadgeText}>
                      {badgeCount > 99 ? '99+' : badgeCount}
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
                    fontWeight: isActive ? '600' : '400',
                  },
                ]}
              >
                {item.title}
              </Text>
            </Pressable>
          );
        })}
      </View>
    </LinearGradient>
  );
}
