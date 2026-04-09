// mobile-app/src/components/app-header.tsx
import { View, Text } from "react-native";
import { useStyles } from "@/styles/styles";
import { useAppColors } from "@/hooks/use-app-colors";

const AppHeader = ({ title }: { title: string }) => {
  const styles = useStyles();
  const COLORS = useAppColors();

  return (
    <View
      style={[
        styles.headerContainer,
        {
          backgroundColor: COLORS.primary, // ✅ theme-safe header bg
        },
      ]}
    >
      <Text
        style={[
          styles.headerText,
          {
            color: COLORS.textInverse, // ✅ always readable on primary bg
          },
        ]}
      >
        {title}
      </Text>
    </View>
  );
};

export default AppHeader;

