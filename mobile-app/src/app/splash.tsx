// src/app/splash.tsx
import { useEffect } from 'react';
import { Image, View } from 'react-native';
import AsyncStorage from '@react-native-async-storage/async-storage';
import { useRouter } from 'expo-router';
import styles from '@/styles/styles';

export default function SplashScreen() {
  const router = useRouter();

  useEffect(() => {
    const checkIntro = async () => {
      const hasSeenIntro = await AsyncStorage.getItem('hasSeenIntro');
      setTimeout(() => {
        if (hasSeenIntro === 'true') {
          router.replace('/(auth)/login'); // or route to your main drawer if already logged in
        } else {
          router.replace('/intro/first_screen');
        }
      }, 2000);
    };
    checkIntro();
  }, []);

  return (
    <View style={styles.container}>
      <Image source={require('@/assets/images/splash.png')} style={styles.logo} resizeMode="contain" />
    </View>
  );
}