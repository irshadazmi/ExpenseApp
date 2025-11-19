import { View, Pressable, Text } from 'react-native';
import { useRouter, usePathname, Route } from 'expo-router';
import { TAB_ITEMS } from '@/constants/TAB_ITEMS';
import { COLORS } from '@/constants/COLORS';
import { IconSymbol } from '@/components/ui/icon-symbol';
import type { SFSymbol } from 'expo-symbols';

export default function TabBar() {
  const router = useRouter();
  const pathname = usePathname();

  return (
    <View style={{ flexDirection: 'row', justifyContent: 'space-around', height: 58, backgroundColor: COLORS.secondary }}>
      {TAB_ITEMS.map((item) => {
        const isActive = pathname === `/${item.name}`;
        return (
          <Pressable key={item.name} onPress={() => router.replace(`/${item.name}` as Route)} style={{ alignItems: 'center' }}>
            <IconSymbol name={item.icon as SFSymbol} color={isActive ? COLORS.primary : COLORS.textSecondary} size={22} />
            <Text style={{ color: isActive ? COLORS.primary : COLORS.textSecondary, fontSize: 12 }}>{item.title}</Text>
          </Pressable>
        );
      })}
    </View>
  );
}
