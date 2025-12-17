// components/ui/icon-symbol.tsx
// Fallback for using MaterialIcons on Android and web.

import MaterialIcons from '@expo/vector-icons/MaterialIcons';
import { SymbolWeight, SymbolViewProps } from 'expo-symbols';
import { ComponentProps } from 'react';
import { OpaqueColorValue, type StyleProp, type TextStyle } from 'react-native';

type IconMapping = Record<SymbolViewProps['name'], ComponentProps<typeof MaterialIcons>['name']>;
type IconSymbolName = keyof typeof MAPPING;

/**
 * Add your SF Symbols to Material Icons mappings here.
 * - see Material Icons in the [Icons Directory](https://icons.expo.fyi).
 * - see SF Symbols in the [SF Symbols](https://developer.apple.com/sf-symbols/) app.
 */
const MAPPING = {
  // ✅ Navigation / UI
  'house.fill': 'home',
  'chevron.right': 'chevron-right',
  'chevron.left.forwardslash.chevron.right': 'code',
  'ellipsis.circle.fill': 'more-horiz',
  'arrow.uturn.left': 'undo',
  'arrow.uturn.right': 'redo',

  // ✅ Communication / Support
  'paperplane.fill': 'send',
  'envelope.badge.fill': 'feedback',
  'bubble.left.fill': 'chat',
  'phone.fill': 'phone',
  'questionmark.circle.fill': 'help',

  // ✅ Search / Discovery
  'magnifyingglass': 'search',

  // ✅ Time / Scheduling
  'calendar': 'calendar-today',
  'clock.fill': 'access-time',

  // ✅ Finance / Transactions
  'wallet.pass.fill': 'account-balance-wallet',
  'banknote.fill': 'account-balance',
  'dollarsign.circle.fill': 'attach-money',
  'creditcard.fill': 'credit-card',
  'chart.bar.fill': 'bar-chart',
  'chart.pie.fill': 'pie-chart',

  // ✅ Files / Content
  'folder.fill': 'folder',
  'tag.fill': 'label',
  'bookmark.fill': 'bookmark',
  'tray.full.fill': 'inbox',
  'paperclip': 'attach-file',
  'link': 'link',

  // ✅ Media / Devices
  'camera.fill': 'photo-camera',
  'mic.fill': 'mic',
  'speaker.wave.2.fill': 'volume-up',
  'wifi': 'wifi',
  'battery.100': 'battery-full',

  // ✅ Shopping / Commerce
  'cart.fill': 'shopping-cart',

  // ✅ Favorites / Ratings
  'heart.fill': 'favorite',
  'star.fill': 'star',

  // ✅ About / Info
  'info.circle': 'info', // About or app information

  // ✅ Notifications
  'bell.fill': 'notifications',

  // ✅ Actions / Utilities
  'plus.circle.fill': 'add-circle',
  'slider.horizontal.3': 'tune',
  'wrench.fill': 'build',

  // ✅ Location
  'location.fill': 'location-on',

  // ✅ Account / Profile
  'person.crop.circle': 'account-circle',
  'person.crop.circle.fill': 'account-circle',
  'person.fill': 'person',
  'person.2.fill': 'group',

  // ✅ Security / Access
  'lock.fill': 'lock',
  'lock.open.fill': 'lock-open',
  'key.fill': 'vpn-key',

  // ✅ Settings / System
  'gearshape.fill': 'settings',

  // ✅ Logout / Exit
  'arrow.right.square.fill': 'logout',
  'rectangle.portrait.and.arrow.right': 'exit-to-app',

  // ✅ AI Assistant
  'robotic.vacuum.fill': 'smart-toy',
  'brain.head.profile': 'insights',

  // ✅ Hamberger Menu
  'line.3.horizontal': 'menu',

  // ✅ Email
  'envelope.fill': 'email',
} as IconMapping;

/**
 * An icon component that uses native SF Symbols on iOS, and Material Icons on Android and web.
 * This ensures a consistent look across platforms, and optimal resource usage.
 * Icon `name`s are based on SF Symbols and require manual mapping to Material Icons.
 */
export function IconSymbol({
  name,
  size = 24,
  color,
  style,
}: {
  name: IconSymbolName;
  size?: number;
  color: string | OpaqueColorValue;
  style?: StyleProp<TextStyle>;
  weight?: SymbolWeight;
}) {
  return <MaterialIcons color={color} size={size} name={MAPPING[name]} style={style} />;
}



