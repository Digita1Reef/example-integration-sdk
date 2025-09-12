import { StatusBar } from "expo-status-bar";
import { useState } from "react";
import type { InitializationDataInterface } from "./interfaces/InitializationDataInterface";
import { SplashScreen } from "./screens/SplashScreen/SplashScreen";
import MainScreen from "./screens/MainScreen/MainScreen";

export default function App() {
  const [isInitialized, setIsInitialized] = useState(false);
  const [initializationData, setInitializationData] =
    useState<InitializationDataInterface | null>(null);

  const handleInitializationComplete = (data: InitializationDataInterface) => {
    console.log("🎯 [App] Inicialização concluída:", data);
    setInitializationData(data);
    setIsInitialized(true);
  };

  if (!isInitialized) {
    return (
      <>
        <StatusBar style="light" />
        <SplashScreen onInitializationComplete={handleInitializationComplete} />
      </>
    );
  }

  return (
    <>
      <StatusBar style="light" />
      <MainScreen initializationData={initializationData} />
    </>
  );
}
