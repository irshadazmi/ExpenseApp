// src/components/TabBar.tsx
import { View, Pressable, Text } from 'react-native';
import { useRouter, useSegments, Route } from 'expo-router';
import { TAB_ITEMS } from '@/constants/TAB_ITEMS';
import { COLORS } from '@/constants/COLORS';
import { IconSymbol } from '@/components/ui/icon-symbol';
import styles from '@/styles/styles';
import type { SFSymbol } from 'expo-symbols';
import { LinearGradient } from 'expo-linear-gradient';

export default function TabBar() {
  const router = useRouter();
  const segments = useSegments(); // array of path segments

  // segments example:
  //  - on Dashboard: []
  //  - on /(budget): ['(budget)']  or sometimes still []
  //  - on /(expense): ['(expense)']

  // let currentTabKey: string = 'dashboard';
  // if (segments.length > 0) {
  //   const first = segments[0];
  //   currentTabKey = first;
  // } else {
  //   currentTabKey = 'dashboard';
  // }

  let currentTabKey: string = segments[0] || "(dashboard)"; // default to "dashboard";

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

          return (
            <Pressable
              key={item.name}
              onPress={() => router.replace(routePath as Route)}
              style={styles.tabItem}
            >
              <View style={styles.tabIconWrapper}>
                <IconSymbol
                  name={item.icon as SFSymbol}
                  size={22}
                  color={isActive ? COLORS.tabActive : COLORS.tabInactive}
                />
                {badgeCount > 0 && (
                  <View style={styles.badgeContainer}>
                    <Text style={styles.badgeText}>
                      {badgeCount > 99 ? '99+' : badgeCount}
                    </Text>
                  </View>
                )}
              </View>
              <Text
                style={[
                  styles.tabLabel,
                  {
                    color: isActive ? COLORS.tabActive : COLORS.tabInactive,
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
