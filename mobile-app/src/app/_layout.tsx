import { useState } from 'react';
import { Slot } from 'expo-router';
import { View, Pressable, Text } from 'react-native';
import TabBar from '@/components/tab_bar';
import CustomDrawer from '@/components/custom_drawer';
import MaterialIcons from '@expo/vector-icons/MaterialIcons';
import { COLORS } from '@/constants/COLORS';

export default function Layout() {
  const [drawerVisible, setDrawerVisible] = useState(false);
  const [title, setTitle] = useState('DASHBOARD');

  return (
    <View style={{ flex: 1 }}>
      {/* Header */}
      <View
        style={{
          height: 56,
          backgroundColor: COLORS.primary,
          flexDirection: 'row',
          alignItems: 'center',
          justifyContent: 'space-between',
          paddingHorizontal: 16,
        }}
      >
        <Pressable onPress={() => setDrawerVisible(true)}>
          <MaterialIcons name="menu" size={24} color={COLORS.white} />
        </Pressable>
        <Text style={{ color: COLORS.white, fontSize: 18, fontWeight: '700' }}>
          {title}
        </Text>
        <View style={{ width: 24 }} />
      </View>

      {/* Page Content */}
      <View style={{ flex: 1 }}>
        <Slot />
      </View>

      {/* Persistent Tab Bar */}
      <TabBar />

      {/* Drawer Overlay */}
      <CustomDrawer
        visible={drawerVisible}
        onClose={() => setDrawerVisible(false)}
        setTitle={setTitle}
      />
    </View>
  );
}