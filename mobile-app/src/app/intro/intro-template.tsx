// src/app/intro/intro-template.tsx
import styles from "@/styles/styles";
import { useRouter } from "expo-router";
import { View, Text, Image, Pressable } from "react-native";

export default function IntroTemplate({ image, title, description, next }: any) {
  const router = useRouter();

  const handleNext = () => {
    if (typeof next === "function") next();
    else router.replace(next);
  };

  return (
    <View style={styles.container}>
      <Image source={image} style={styles.image} resizeMode="contain" />

      <Text style={styles.title}>{title}</Text>
      <Text style={styles.description}>{description}</Text>

      <Pressable style={styles.button} onPress={handleNext}>
        <Text style={styles.buttonText}>Next</Text>
      </Pressable>
    </View>
  );
}
