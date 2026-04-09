// src/app/splash.tsx

import { useEffect } from "react";
import { Image, View } from "react-native";
import AsyncStorage from "@react-native-async-storage/async-storage";
import { useRouter } from "expo-router";

import { useStyles } from "@/styles/styles";
import { useAppColors } from "@/hooks/use-app-colors";

export default function SplashScreen() {
  const styles = useStyles();
  const COLORS = useAppColors();
  const router = useRouter();

  useEffect(() => {
    const checkIntro = async () => {
      const flag = await AsyncStorage.getItem("hasSeenIntro");

      setTimeout(() => {
        if (flag === "true") {
          router.replace("/(auth)/login");
        } else {
          router.replace("/intro/first_screen");
        }
      }, 2000);
    };

    checkIntro();
  }, []);

  return (
    <View
      style={[
        styles.container,
        { backgroundColor: COLORS.background },
      ]}
    >
      <Image
        source={require("@/assets/images/splash.png")}
        style={styles.logo}
        resizeMode="contain"
      />
    </View>
  );
}
