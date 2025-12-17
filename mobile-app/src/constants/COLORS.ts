import { useMemo } from "react";
import { useColorScheme } from "react-native";
import { getColors } from "./theme";

const scheme = useColorScheme();
export const COLORS = useMemo(
  () => getColors(scheme === "dark" ? "dark" : "light"),
  [scheme]
);