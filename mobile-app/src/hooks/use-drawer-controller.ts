import { useContext } from "react";
import { DrawerContext } from "@/contexts/drawer-context";

export default function useDrawerController() {
  return useContext(DrawerContext);
}
