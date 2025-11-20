// src/components/custom-drawer.tsx
import { View, Text, Pressable, Modal } from "react-native";
import { DRAWER_ITEMS } from "@/constants/DRAWER_ITEMS";
import { Route, useRouter, usePathname, useSegments } from "expo-router";
import { COLORS } from "@/constants/COLORS";
import { IconSymbol } from "@/components/ui/icon-symbol";
import type { SFSymbol } from "expo-symbols";
import styles from "@/styles/styles";

type Props = {
  visible: boolean;
  onClose: () => void;
  setTitle: (title: string) => void;
};

export default function CustomDrawer({ visible, onClose, setTitle }: Props) {
  const router = useRouter();
  const pathname = usePathname();

  const segments = useSegments(); // array of path segments
  // Derive a "currentDrawerKey"
  let currentDrawerKey: string = segments[0] || "(dashboard)"; // default to "dashboard";

  return (
    <Modal visible={visible} animationType="slide" transparent>
      <View style={styles.backdrop}>
        <View style={styles.drawerContainer}>
          {DRAWER_ITEMS.map((item) => {
            const routePath = `/${item.name}`;
            const isActive = currentDrawerKey === item.name;

            return (
              <Pressable
                key={item.name}
                onPress={() => {
                  onClose();
                  setTitle(item.title.toUpperCase());
                  router.replace(routePath as Route);
                }}
                style={[
                  styles.drawerItem,
                  isActive && styles.drawerItemActive,
                ]}
              >
                <IconSymbol
                  name={item.icon as SFSymbol}
                  size={22}
                  color={isActive ? COLORS.tabActive : COLORS.tabInactive}
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
        </View>
        {/* tap outside to close */}
        <Pressable onPress={onClose} style={{ flex: 1 }} />
      </View>
    </Modal>
  );
}