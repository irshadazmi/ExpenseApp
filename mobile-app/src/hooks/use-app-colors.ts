import { useMemo } from "react";
import { getColors } from "@/constants/theme";
import { useTheme } from "@/contexts/theme-context";

export const useAppColors = () => {
  const { resolvedMode } = useTheme();

  return useMemo(
    () => getColors(resolvedMode),
    [resolvedMode]
  );
};
