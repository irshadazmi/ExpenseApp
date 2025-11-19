// src/components/custom-drawer.tsx
import { View, Text, Pressable, Modal } from 'react-native';
import { DRAWER_ITEMS } from '@/constants/DRAWER_ITEMS';
import { Route, useRouter } from 'expo-router';
import { COLORS } from '@/constants/COLORS';
import { IconSymbol } from '@/components/ui/icon-symbol';
import type { SFSymbol } from 'expo-symbols';

type Props = {
  visible: boolean;
  onClose: () => void;
  setTitle: (title: string) => void;
};

export default function CustomDrawer({ visible, onClose, setTitle }: Props) {
  const router = useRouter();

  return (
    <Modal visible={visible} animationType="slide" transparent>
      <View style={{ flex: 1, backgroundColor: '#00000088' }}>
        <View style={{ backgroundColor: COLORS.white, padding: 20, marginTop: 60 }}>
          {DRAWER_ITEMS.map((item) => (
            <Pressable
              key={item.name}
              onPress={() => {
                onClose();
                setTitle(item.title.toUpperCase());
                router.replace(`/${item.name}` as Route);
              }}
              style={{
                flexDirection: 'row',
                alignItems: 'center',
                paddingVertical: 12,
                gap: 12,
              }}
            >
              <IconSymbol name={item.icon as SFSymbol} color={COLORS.primary} size={22} />
              <Text style={{ fontSize: 16, fontWeight: '600', color: COLORS.text }}>
                {item.title}
              </Text>
            </Pressable>
          ))}
        </View>
        <Pressable onPress={onClose} style={{ flex: 1 }} />
      </View>
    </Modal>
  );
}