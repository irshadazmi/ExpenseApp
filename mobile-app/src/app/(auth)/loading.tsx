import React from "react";
import {
  View,
  Text,
  Image,
  ActivityIndicator,
} from "react-native";

import { useStyles } from "@/styles/styles";
import { useAppColors } from "@/hooks/use-app-colors";

/* ======================================================
    LOADING SCREEN
====================================================== */

const Loading = () => {
  const styles = useStyles();
  const COLORS = useAppColors(); // ✅ unified theming

  return (
    <View
      style={[
        styles.container,
        {
          justifyContent: "center",
          alignItems: "center",
        },
      ]}
    >
      {/* ---------- LOGO ---------- */}
      <Image
        source={require("@/assets/images/expense-logo.png")}
        style={{
          width: 72,
          height: 72,
          marginBottom: 16,
        }}
        resizeMode="contain"
      />

      {/* ---------- LOADER ---------- */}
      <ActivityIndicator
        size="large"
        color={COLORS.primary}
      />

      {/* ---------- TITLE ---------- */}
      <Text
        style={[
          styles.title,
          {
            marginTop: 18,
            color: COLORS.text,
          },
        ]}
      >
        Loading…
      </Text>
    </View>
  );
};

export default Loading;
