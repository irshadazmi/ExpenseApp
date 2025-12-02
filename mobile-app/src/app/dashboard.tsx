import { useEffect, useState } from 'react';
import { View, Text } from 'react-native';
import { dashboardService } from '@/services/dashboard-service';
import { useAuth } from '@/contexts//auth-context';
import styles from '@/styles/styles';

const DashboardScreen = () => {
  const { user } = useAuth();

  const [summary, setSummary] = useState<any>(null);

  useEffect(() => {
    if (!user?.id) return;

    dashboardService.getSummary(user.id)
      .then(setSummary)
      .catch(console.error);
  }, []);

  if (!summary) return <Text>Loading…</Text>;

  return (
    <View style={ styles.container}>
      <Text style={styles.title}>Total Budget: ₹{summary.total_budget}</Text>
      <Text style={styles.title}>Total Spent: ₹{summary.total_spent}</Text>
      <Text style={styles.title}>Remaining: ₹{summary.remaining}</Text>
      <Text style={styles.title}>Usage: {summary.percent_used}%</Text>
    </View>
  );
};

export default DashboardScreen;
