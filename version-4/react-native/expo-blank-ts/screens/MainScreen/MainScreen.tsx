import { StatusBar } from "expo-status-bar";
import { Text, View } from "react-native";
import { styles } from "./styles";
import type { InitializationDataInterface } from "../../interfaces/InitializationDataInterface";

interface MainScreenProps {
  initializationData: InitializationDataInterface | null;
}

export function MainScreen({ initializationData }: MainScreenProps) {
  return (
    <View style={styles.container}>
      <Text>Open up App.tsx to start working on your app!</Text>
      <StatusBar style="auto" />
    </View>
  );
}
