import { StatusBar } from "expo-status-bar";
import { Text, View } from "react-native";
import type { InitializationDataInterface } from "../../interfaces/InitializationDataInterface";
import { styles } from "./styles";

interface MainScreenProps {
  initializationData: InitializationDataInterface | null;
}

export default function MainScreen({ initializationData }: MainScreenProps) {
  return (
    <View style={styles.container}>
      <Text style={styles.text}>
        Open up App.tsx to start working on your app!
      </Text>
      <StatusBar style="auto" />
    </View>
  );
}
