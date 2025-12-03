import { Platform, View, Text } from "react-native";
import { VictoryPie } from "victory";

const PieChart = (props: any) => {

  if (Platform.OS === "web") {
    return (
      <View style={{ padding: 20 }}>
        <Text style={{ opacity: 0.5, textAlign: "center" }}>
          Chart preview disabled on Web
        </Text>
      </View>
    );
  }

  return <VictoryPie {...props} />;
};

export default PieChart;
