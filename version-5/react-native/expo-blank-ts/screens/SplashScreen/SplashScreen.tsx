import { useEffect, useState } from "react";
import { Animated, View, Text, Platform } from "react-native";
import { styles } from "./styles";
import SiprocalSdk from "siprocalsdk-reactnative-plugin";

interface SplashScreenProps {
  onInitializationComplete: (result: any) => void;
}

export const SplashScreen = ({
  onInitializationComplete,
}: SplashScreenProps) => {
  const [progress, setProgress] = useState(0);
  const [statusText, setStatusText] = useState("Carregando...");
  const [fadeAnim] = useState(new Animated.Value(0));
  const [progressAnim] = useState(new Animated.Value(0));
  const [scaleAnim] = useState(new Animated.Value(0.5));

  useEffect(() => {
    // Animação inicial do splash
    Animated.parallel([
      Animated.timing(fadeAnim, {
        toValue: 1,
        duration: 800,
        useNativeDriver: true,
      }),
      Animated.spring(scaleAnim, {
        toValue: 1,
        tension: 100,
        friction: 8,
        useNativeDriver: true,
      }),
    ]).start();

    // Inicializar SDK
    initializeSiprocalSDK();
  }, []);

  const initializeSiprocalSDK = async () => {
    try {
      console.log("🚀 [SplashScreen] Obtendo informações do SDK...");
      // Etapa 1: Verificando disponibilidade do módulo
      updateProgress(
        10,
        "[SplashScreen] Verificando módulo SDK siprocalsdk-reactnative-plugin..."
      );

      await delay(1000);

      if (!SiprocalSdk) {
        throw new Error(
          "[SplashScreen] Módulo SiprocalSdk não está disponível."
        );
      }

      // Etapa 2: Obtendo informações do SDK
      updateProgress(50, "[SplashScreen] Obtendo informações do SDK...");

      const sdkInfo = await SiprocalSdk.getSdkInformation();
      console.log("✅ [SplashScreen] Informações do SDK obtidas:", sdkInfo);

      await delay(1000);

      // Etapa 3: Finalizando inicialização
      updateProgress(100, "Inicialização completa!");
      await delay(1000);

      // Navegar para a tela principal
      onInitializationComplete({
        success: true,
        data: JSON.parse(sdkInfo),
        timestamp: new Date().toISOString(),
      });
    } catch (error: Error | any) {
      console.log(
        "❌ [SplashScreen] Erro durante inicialização:",
        error.message
      );

      updateProgress(100, "Erro na inicialização");
      await delay(1000);

      // Mesmo com erro, navegar para a tela principal
      onInitializationComplete({
        success: false,
        error: error.message,
        timestamp: new Date().toISOString(),
      });
    }
  };

  const delay = (ms: number) =>
    new Promise((resolve) => setTimeout(resolve, ms));

  const updateProgress = (newProgress: number, newStatusText: string) => {
    setProgress(newProgress);
    setStatusText(newStatusText);

    // Animar barra de progresso
    Animated.timing(progressAnim, {
      toValue: newProgress / 100,
      duration: 200,
      useNativeDriver: false,
    }).start();
  };

  return (
    <View style={styles.container}>
      {/* Background Gradient Effect */}
      <View style={styles.backgroundGradient} />

      <Animated.View
        style={[
          styles.content,
          {
            opacity: fadeAnim,
            transform: [{ scale: scaleAnim }],
          },
        ]}
      >
        {/* Logo/Icon */}
        <View style={styles.logoContainer}>
          <Text style={styles.logoIcon}>🛡️</Text>
          <Text style={styles.logoText}>Digital Reef SDK</Text>
          <Text style={styles.logoSubtext}>
            Inicializando sistema de análise
          </Text>
        </View>

        {/* Progress Section */}
        <View style={styles.progressContainer}>
          <Text style={styles.statusText}>{statusText}</Text>

          {/* Progress Bar */}
          <View style={styles.progressBarBackground}>
            <Animated.View
              style={[
                styles.progressBarFill,
                {
                  width: progressAnim.interpolate({
                    inputRange: [0, 1],
                    outputRange: ["0%", "100%"],
                  }),
                },
              ]}
            />
          </View>

          {/* Progress Percentage */}
          <Text style={styles.progressText}>{progress}%</Text>
        </View>

        {/* Loading Animation */}
        <View style={styles.loadingContainer}>
          <View style={styles.loadingDots}>
            {[0, 1, 2].map((index) => (
              <Animated.View
                key={index}
                style={[
                  styles.loadingDot,
                  {
                    opacity: fadeAnim,
                    transform: [
                      {
                        scale: scaleAnim.interpolate({
                          inputRange: [0, 1],
                          outputRange: [0.5, 1],
                        }),
                      },
                    ],
                  },
                ]}
              />
            ))}
          </View>
        </View>

        {/* Footer */}
        <View style={styles.footer}>
          <Text style={styles.footerText}>Powered by Digital Reef</Text>
          <Text style={styles.versionText}>
            SDK v4.28.7 • React Native 0.79.6
          </Text>
        </View>
      </Animated.View>
    </View>
  );
};
