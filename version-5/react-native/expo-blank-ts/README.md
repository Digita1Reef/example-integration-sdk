# Expo Blank TypeScript - React Native + Siprocal SDK v5

Este é um projeto React Native com **Expo** e **TypeScript** que demonstra a integração completa do **Siprocal SDK v5** usando o plugin React Native.

## 🎯 Sobre Este Projeto

Este exemplo foi criado a partir do template "blank" do Expo com TypeScript, mostrando como integrar o Siprocal SDK em um projeto React Native moderno, servindo como referência para desenvolvedores que querem implementar o SDK em seus apps.

## 📦 Configuração do Projeto

### Dependências Principais

- **Expo**: ~54.0.2
- **React Native**: 0.81.4
- **TypeScript**: ~5.9.2
- **siprocalsdk-reactnative-plugin**: via yalc (local)

### Arquivos de Configuração

- ✅ `android/app/src/main/assets/siprocal-config.json` - Configuração Android
- ✅ `ios/LocalConfig.plist` - Configuração iOS

## 🏗️ Estrutura do Projeto

```
.
├── App.tsx                      # Componente principal do app
├── interfaces/
│   └── InitializationDataInterface.ts  # Interface TypeScript
├── screens/
│   ├── SplashScreen/
│   │   └── SplashScreen.tsx     # Tela inicial com inicialização do SDK
│   └── MainScreen/
│       └── MainScreen.tsx       # Tela principal do app
├── android/                     # Configurações Android
└── ios/                         # Configurações iOS
```

## 🚀 Como Executar

### Pré-requisitos

- Node.js 16+
- Expo CLI
- Android Studio (para Android)
- Xcode (para iOS)

### Passos

1. **Navegue para o projeto**:

   ```bash
   cd version-5/react-native/expo-blank-ts/
   ```

2. **Instale as dependências**:

   ```bash
   npm install
   # ou
   yarn install
   ```

3. **Inicie o desenvolvimento**:

   ```bash
   npx expo start
   ```

4. **Execute em dispositivo/emulador**:

   ```bash
   # Android
   npx expo run:android

   # iOS
   npx expo run:ios
   ```

> ⚠️ **Importante**: Este projeto requer **Development Build** pois usa módulos nativos. Não funcionará no Expo Go.

## 🔧 Implementação do SDK

### 1. Verificação do SDK

O SDK é verificado na `SplashScreen`:

```typescript
import SiprocalSdk from "siprocalsdk-reactnative-plugin";

const SplashScreen = ({ onInitializationComplete }) => {
  useEffect(() => {
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
```

### 2. Configuração Android

No arquivo `android/app/build.gradle`:

```gradle
dependencies {
    implementation('com.digitalreef.phoenix:chronos:5.8.1')
    // ... outras dependências
}
```

**Nota**: O projeto usa a variante **Chronos** no React Native, enquanto o Flutter usa **Helios**.

### 3. Fluxo da Aplicação

1. **SDK Auto-inicialização**: O SDK se inicializa automaticamente ao ser carregado
2. **App.tsx**: Controla o estado global de verificação
3. **SplashScreen**: Exibe animações e verifica status do SDK
4. **Progresso Visual**: Animações com barra de progresso
5. **Verificação**: `getSdkInformation()` confirma que está funcionando
6. **Transição**: Após verificação, navega para MainScreen
7. **MainScreen**: Tela principal (atualmente simples)### 4. TypeScript Interfaces

```typescript
export interface InitializationDataInterface {
  success: boolean;
  timestamp: string;
  data?: any;
  error?: string;
}
```

## 📱 Recursos Implementados

### ✅ Implementado

- ✅ Auto-inicialização do SDK (automática)
- ✅ Verificação de status com `getSdkInformation()`
- ✅ Configuração Android com `siprocal-config.json`
- ✅ Configuração iOS com `LocalConfig.plist`
- ✅ Interface TypeScript para type safety
- ✅ Tratamento de erros na verificação
- ✅ Estados de loading e sucesso/erro
- ✅ Console logs detalhados para debugging

### ❌ Não Implementado (Propositalmente)

- ❌ Firebase Cloud Messaging
- ❌ Permissões avançadas (localização, Bluetooth)
- ❌ Configurações de dados sensíveis
- ❌ Push notifications customizadas

## 📋 Development Build Required

### Por que Development Build?

Como o Siprocal SDK é um módulo nativo, ele não pode ser executado no Expo Go. É necessário criar um development build:

```bash
# Instalar expo-dev-client
npx expo install expo-dev-client

# Criar build de desenvolvimento
npx expo run:android
npx expo run:ios
```

### Limitações do Expo Go

- ❌ **Não funciona** no Expo Go devido a módulos nativos
- ✅ **Funciona** com development builds
- ✅ **Funciona** em production builds (EAS Build)

## 🧩 Personalização

### Plugin do SDK

O projeto usa o plugin via yalc (local). Para usar em produção:

1. Instale via npm/yarn:

   ```bash
   npm install siprocalsdk-react-plugin
   ```

2. Atualize as configurações conforme necessário

### Configurações

- **Android**: Edite `android/app/src/main/assets/siprocal-config.json`
- **iOS**: Edite `ios/LocalConfig.plist`

## 📊 Histórico de Commits

Este projeto foi desenvolvido com commits explicativos que mostram cada passo da integração. Você pode ver o histórico completo com:

```bash
git log --oneline --grep="version-5.*react-native.*expo-blank-ts"
```

**Sequência real de desenvolvimento:**

1. **`fbb2f38`** - 🎬 `[version-5 | react-native | expo-blank-ts] - Inicializando projeto`
2. **`5461b13`** - 🔧 `[version-5 | react-native | expo-blank-ts] Executando comando prebuild`
3. **`941a2e8`** - 📦 `[version-5 | react-native | expo-blank-ts] Incluindo SDK 5.8.1`
4. **`4dec3d4`** - 📋 `[version-5 | react-native | expo-blank-ts] Incluindo arquivos de configuração do SDK`
5. **`95e8d2d`** - 🔧 `[version-5 | react-native | expo-blank-ts] Configuração do Maven para obter sdk nativo android`
6. **`7ae0933`** - 🤖 `[version-5 | react-native | expo-blank-ts] Incluindo dependencia com.digitalreef.phoenix`
7. **`6b401f4`** - 🚀 `[version-5 | react-native | expo-blank-ts] Inicializando o plugin Siprocal no nativo Android`
8. **`860a32e`** - 🛡️ `[version-5 | react-native | expo-blank-ts] Incluindo regras do proguard`
9. **`c5d7e22`** - 🔐 `[version-5 | react-native | expo-blank-ts] Incluindo permissões obrigatorias SDK Siprocal`
10. **`033fedc`** - 🔐 `[version-5 | react-native | expo-blank-ts] Incluindo permissões exclusivas das variantes Helios e Hestia`
11. **`2c7a00a`** - 🏢 `[version-5 | react-native | expo-blank-ts] Alterando organização de IU para Siprocal`
12. **`1e5959a`** - ⚠️ `[HACK - SOMENTE DESENVOLVIMENTO] Alterando applicationId para funcionar com package da Siprocal`
13. **`8e8666e`** - ✅ `[version-5 | react-native | expo-blank-ts] Incluindo Inicialização do SDK em Splash Screen`

## 🐛 Debugging

### Logs Importantes

O projeto inclui logs detalhados que ajudam no debugging:

```typescript
console.log("🚀 [App] Aplicativo iniciado");
console.log("🎯 [Splash] Inicializando Siprocal SDK...");
console.log("✅ [Splash] SDK inicializado com sucesso!");
```

### Problemas Comuns

1. **Expo Go não funciona**: Use development build em vez do Expo Go
2. **Metro bundler issues**: Execute `npx expo start --clear`
3. **SDK não inicializa**: Verifique arquivos de configuração
4. **Build errors**: Confirme que as configurações nativas estão corretas

### Metro Bundle Reset

```bash
npx expo start --clear
```

## 🔧 Comandos Úteis

```bash
# Desenvolvimento
npm start              # Inicia o Expo
npm run android        # Development build Android
npm run ios           # Development build iOS

# Build e deploy
npx expo build        # Build de produção
npx eas build         # EAS Build (recomendado)
```

## 📚 Referências

- [Documentação React Native + Siprocal](https://developers.digitalreef.com/docs/integrating-siprocal-sdk-1)
- [Configuração Android](https://developers.digitalreef.com/docs/android-integration-1)
- [Configuração iOS](https://developers.digitalreef.com/docs/ios-integration-copy)
- [Métodos Adicionais React](https://developers.digitalreef.com/docs/additional-methods-react)
- [Expo Documentation](https://docs.expo.dev/)

## 💡 Próximos Passos

Após executar este exemplo com sucesso, você pode:

1. **Integrar em seu projeto** seguindo os mesmos passos
2. **Adicionar navegação** com React Navigation
3. **Implementar push notifications** com Expo Notifications
4. **Explorar APIs avançadas** do SDK
5. **Deploy** usando EAS Build

## ⚠️ Notas Importantes

- 📱 **Teste em dispositivos reais** para validar funcionalidades nativas
- 🔧 **Use development builds** para testar o SDK
- 📝 **Siga a documentação** oficial para configurações avançadas
- 🚀 **EAS Build** é recomendado para builds de produção

---

**⚛️ Este projeto serve como base sólida para qualquer integração do Siprocal SDK em React Native com Expo!**
