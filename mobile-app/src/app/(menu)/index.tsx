// src/app/(menu)/index.tsx
import { useEffect } from 'react';
import { router } from 'expo-router';
import { View } from 'react-native';
import useDrawerController from '@/hooks/use-drawer-controller';

export default function MenuTrigger() {
  const { openDrawer } = useDrawerController();

  useEffect(() => {
    openDrawer();
    router.back(); // Return to previous screen instantly
  }, []);

  return <View />;
}
