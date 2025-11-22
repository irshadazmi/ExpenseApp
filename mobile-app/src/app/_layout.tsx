// src/app/_layout.tsx (or wherever RootLayout is)
import { useEffect, useState } from 'react';
import { router, Slot, Stack, usePathname } from 'expo-router';
import { View, Pressable, Text, useColorScheme, StatusBar } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import TabBar from '@/components/tab-bar';
import CustomDrawer from '@/components/custom-drawer';
import MaterialIcons from '@expo/vector-icons/MaterialIcons';
import { COLORS } from '@/constants/COLORS';
import { IconSymbol } from '@/components/ui/icon-symbol';
import { AuthProvider, useAuth } from '@/contexts/auth-context';
import AsyncStorage from '@react-native-async-storage/async-storage';
import Loading from './(auth)/loading';
import { DarkTheme, DefaultTheme, ThemeProvider } from '@react-navigation/native';
import { DRAWER_ITEMS } from '@/constants/DRAWER_ITEMS';
import { PUBLIC_ROUTES } from '@/constants/PUBLIC_ROUTES';

export default function RootLayout() {
  return (
    <AuthProvider>
      <RootLayoutContent />
    </AuthProvider>
  );
}

function RootLayoutContent() {
  const colorScheme = useColorScheme();
  const { user, loading } = useAuth();
  const pathname = usePathname();

  const [drawerVisible, setDrawerVisible] = useState(false);
  const [title, setTitle] = useState('DASHBOARD');

  const [introChecked, setIntroChecked] = useState(false);
  const [hasSeenIntro, setHasSeenIntro] = useState(false);

  // Intro flag
  useEffect(() => {
    (async () => {
      const flag = await AsyncStorage.getItem('hasSeenIntro');
      setHasSeenIntro(flag === 'true');
      setIntroChecked(true);
    })();
  }, []);

  useEffect(() => {
    if (!introChecked) return;
    if (hasSeenIntro === false) {
      router.replace('/intro/first_screen');
    }
  }, [introChecked, hasSeenIntro]);

  // 🔒 Route guard
  useEffect(() => {
    if (loading) return;

    const isPublic = PUBLIC_ROUTES.some(route =>
      pathname === route || pathname.startsWith(route + '/')
    );

    // If not logged in and NOT on a public route → send to login
    if (!user && !isPublic) {
      router.replace('/(auth)/login');
    }
  }, [pathname, user, loading]);

  // Header title
  useEffect(() => {
    const folder = pathname.split('/')[1] || 'dashboard';
    const matched = DRAWER_ITEMS.find((item) => item.name === folder);
    if (matched) setTitle(matched.title.toUpperCase());
  }, [pathname]);

  if (loading || !introChecked) {
    return <Loading />;
  }

  // Public (auth) stack
  if (!user) {
    return (
      <ThemeProvider value={colorScheme === 'dark' ? DarkTheme : DefaultTheme}>
        <Stack screenOptions={{ headerShown: false }}>
          <Stack.Screen name="(auth)" />
        </Stack>
        <StatusBar
          barStyle={colorScheme === 'dark' ? 'light-content' : 'dark-content'}
          backgroundColor={colorScheme === 'dark' ? '#151718' : '#FFFFFF'}
        />
      </ThemeProvider>
    );
  }

  // Private (logged in) area
  return (
    <ThemeProvider value={colorScheme === 'dark' ? DarkTheme : DefaultTheme}>
      <SafeAreaView style={{ flex: 1, backgroundColor: COLORS.white }}>
        {/* Header */}
        <View
          style={{
            height: 72,
            backgroundColor: COLORS.primary,
            flexDirection: 'row',
            alignItems: 'center',
            justifyContent: 'space-between',
            paddingHorizontal: 16,
          }}
        >
          <Pressable onPress={() => setDrawerVisible(true)} style={{ padding: 8 }}>
            <MaterialIcons name="menu" size={28} color={COLORS.white} />
          </Pressable>
          <Text style={{ color: COLORS.white, fontSize: 18, fontWeight: '700' }}>
            {title}
          </Text>
          <Pressable onPress={() => router.replace('/logout')} style={{ padding: 8 }}>
            <IconSymbol name="arrow.right.square.fill" color={COLORS.white} size={28} />
          </Pressable>
        </View>

        {/* Page Content */}
        <View style={{ flex: 1 }}>
          <Slot />
        </View>

        {/* Tab Bar */}
        <TabBar />

        {/* Drawer */}
        <CustomDrawer
          visible={drawerVisible}
          onClose={() => setDrawerVisible(false)}
          setTitle={setTitle}
        />
      </SafeAreaView>

      <StatusBar
        barStyle={colorScheme === 'dark' ? 'light-content' : 'dark-content'}
        backgroundColor={colorScheme === 'dark' ? '#151718' : '#FFFFFF'}
      />
    </ThemeProvider>
  );
}
