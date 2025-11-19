// mobile-app/src/app/%28auth%29/_layout.tsx
import { useAuth } from '@/contexts/auth-context';
import { Slot } from 'expo-router';
import Loading from './loading';

export default function RootLayout() {
  const { user, loading } = useAuth();
  if (loading) return <Loading />;

  return <Slot />;
}