// src/components/custom-drawer.tsx

import { View, Text, Pressable, Modal } from "react-native";
import { DRAWER_ITEMS } from "@/constants/DRAWER_ITEMS";
import { Route, useRouter, useSegments } from "expo-router";
import { IconSymbol } from "@/components/ui/icon-symbol";
import type { SFSymbol } from "expo-symbols";
import { useStyles } from "@/styles/styles";
import { useAppColors } from "@/hooks/use-app-colors";

type Props = {
  visible: boolean;
  onClose: () => void;
  setTitle: (title: string) => void;
};

export default function CustomDrawer({ visible, onClose, setTitle }: Props) {
  const COLORS = useAppColors();
  const styles = useStyles();
  const router = useRouter();
  const segments = useSegments();

  const currentDrawerKey: string = segments[0] || "(dashboard)";

  return (
    <Modal visible={visible} animationType="slide" transparent>
      {/* Backdrop */}
      <Pressable style={styles.backdrop} onPress={onClose}>
        {/* POSITION WRAPPER – does not change existing styles */}
        <View
          style={{
            width: "80%",
            position: "absolute",
            right: 0,
            bottom: 64,        // aligns above bottom tab bar
          }}
        >
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
                    color={
                      isActive ? COLORS.tabActive : COLORS.tabInactive
                    }
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
        </View>
      </Pressable>
    </Modal>
  );
}
