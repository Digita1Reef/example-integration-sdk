import { useEffect, useState } from "react";
import { Animated, Platform, View, Text } from "react-native";
import IuLibraryModule from "react-native-iu-library";
import { NativeModules } from "react-native";
import { styles } from "./styles";
import type { InitializationDataInterface } from "../../interfaces/InitializationDataInterface";

const RCTDigitalReefSDK = NativeModules.IuLibraryModule;

interface SplashScreenProps {
  onInitializationComplete: (result: InitializationDataInterface) => void;
}

export const SplashScreen = ({
  onInitializationComplete,
}: SplashScreenProps) => {
  const [progress, setProgress] = useState(0);
  const [statusText, setStatusText] = useState("Inicializando...");
  const [progressAnim] = useState(new Animated.Value(0));
  const [fadeAnim] = useState(new Animated.Value(0));
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
    initializeDigitalReefSDK();
  }, []);

  // ============================================================================
  // DIGITAL REEF SDK - Inicialização completa do SDK
  // ============================================================================
  const initializeDigitalReefSDK = async () => {
    try {
      console.log(
        "🚀 [SplashScreen] Iniciando inicialização completa do Digital Reef SDK"
      );

      // Etapa 1: Verificar disponibilidade do módulo
      updateProgress(
        10,
        "[SplashScreen] Verificando módulo SDK NativeModules.IuLibraryModule..."
      );
      await delay(500);

      if (!RCTDigitalReefSDK) {
        throw new Error(
          "[SplashScreen] Módulo Digital (NativeModules.IuLibraryModule) Reef SDK não encontrado"
        );
      }

      // Etapa 2: Inicializar SDK
      updateProgress(30, "[SplashScreen] Inicializando SDK...");
      await delay(300);

      if (RCTDigitalReefSDK.initSDK) {
        console.log("🔧 [SplashScreen] Executando initSDK()");
        RCTDigitalReefSDK.initSDK();
      }

      // Etapa 4: Aguardar inicialização
      updateProgress(70, "[SplashScreen] Aguardando inicialização...");
      await delay(2000); // Aguardar SDK inicializar

      // Etapa 5: Verificar status
      updateProgress(85, "[SplashScreen] Verificando status...");
      await delay(500);

      let sdkStatus = "Desconhecido";
      try {
        sdkStatus = await IuLibraryModule.getStatus();
        console.log("✅ [SplashScreen] Status do SDK:", sdkStatus);
      } catch (error: Error | any) {
        console.log("⚠️ [SplashScreen] Erro ao obter status:", error.message);
      }

      // Etapa 6: Configurações adicionais (se necessário)
      updateProgress(95, "[SplashScreen] Finalizando configuração...");
      await delay(300);

      // iOS específico
      if (Platform.OS === "ios" && NativeModules.IuLibraryModule.initiOS) {
        console.log(
          "🍎 [SplashScreen] Executando configuração específica do iOS"
        );
        NativeModules.IuLibraryModule.initiOS();
      }

      // Etapa 7: Concluído
      updateProgress(100, "[SplashScreen] SDK inicializado com sucesso!");
      await delay(500);

      console.log(
        "✅ [SplashScreen] Inicialização do Digital Reef SDK concluída"
      );

      // Aguardar um pouco antes de navegar
      setTimeout(() => {
        onInitializationComplete({
          success: true,
          status: sdkStatus,
          timestamp: new Date().toISOString(),
        });
      }, 1000);
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
