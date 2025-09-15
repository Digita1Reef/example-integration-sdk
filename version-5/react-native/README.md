# React Native - Siprocal SDK v5

Esta pasta contém exemplos de integração do **Siprocal SDK v5** para projetos **React Native**.

## 🎯 Sobre a Integração React Native

O Siprocal SDK para React Native oferece uma ponte nativa completa entre JavaScript e as APIs nativas Android/iOS, permitindo que desenvolvedores React Native aproveitem todos os recursos da plataforma de análise e engajamento.

## 📂 Projetos Disponíveis

### [`expo-blank-ts/`](./expo-blank-ts/)

Projeto React Native com Expo e TypeScript criado especificamente para demonstrar a integração básica do Siprocal SDK.

**Características:**

- ✅ Projeto Expo com template "blank" TypeScript
- ✅ Integração completa do SDK v5
- ✅ Configuração Android e iOS
- ✅ Exemplo de verificação do SDK
- ✅ Commits explicativos de cada passo

## 🚀 Começando Rapidamente

1. **Navegue para o projeto**:

   ```bash
   cd expo-blank-ts/
   ```

2. **Instale as dependências**:

   ```bash
   npm install
   # ou
   yarn install
   ```

3. **Execute o projeto**:
   ```bash
   npx expo start
   # ou
   yarn start
   ```

## 📖 Documentação de Referência

### Guias Oficiais React Native

- 📚 [**Integração Principal**](https://developers.digitalreef.com/docs/integrating-siprocal-sdk-1) - Como adicionar o SDK ao projeto
- 🤖 [**Configuração Android**](https://developers.digitalreef.com/docs/android-integration-1) - Setup específico para Android
- 🍎 [**Configuração iOS**](https://developers.digitalreef.com/docs/ios-integration-copy) - Setup específico para iOS
- 🛠️ [**Métodos Adicionais**](https://developers.digitalreef.com/docs/additional-methods-react) - APIs avançadas em JavaScript

## 🔧 Processo de Integração

### 1. Adicionar Dependência

```bash
npm install siprocalsdk-react-plugin
# ou
yarn add siprocalsdk-react-plugin
```

### 2. Configuração Android

- Adicionar repositórios no `android/build.gradle`:
  ```gradle
  allprojects {
      repositories {
          mavenCentral()
      }
  }
  ```
- Adicionar dependência no `android/app/build.gradle`:
  ```gradle
  implementation 'com.digitalreef.phoenix:<variant>:<version>'
  ```
- Criar `android/app/src/main/assets/siprocal-config.json`
- Configurar `AndroidManifest.xml` com Application class

### 3. Configuração iOS

- Adicionar `LocalConfig.plist` ao projeto iOS
- Configurar permissões necessárias
- Atualizar configurações do Xcode se necessário

### 4. Verificação do SDK

```typescript
import SiprocalSdk from "siprocalsdk-reactnative-plugin";

// O SDK se auto-inicializa. Apenas verificamos se está funcionando:
const sdkInfo = await SiprocalSdk.getSdkInformation();
```

## ⚙️ Requisitos Técnicos

- **React Native**: 0.68.0 ou superior
- **Node.js**: 16.0 ou superior
- **Expo**: 49.0 ou superior
- **TypeScript**: 4.0 ou superior
- **Android**: API level 21 (Android 5.0) ou superior
- **iOS**: 11.0 ou superior

## 📱 Plataformas Suportadas

| Plataforma | Status           | Notas                    |
| ---------- | ---------------- | ------------------------ |
| Android    | ✅ Suportado     | API 21+                  |
| iOS        | ✅ Suportado     | iOS 11.0+                |
| Expo Go    | ⚠️ Limitado      | Requer development build |
| Web        | ❌ Não suportado | SDK é nativo             |

## 🚨 Importantes Considerações

### ✅ O que está incluído:

- Configuração básica do SDK
- Inicialização adequada
- Plugin React Native bridge
- Configurações mínimas necessárias
- Permissões básicas

### ❌ O que NÃO está incluído:

- Integração com Firebase Cloud Messaging
- Configurações avançadas opcionais
- Recursos de coleta de dados sensíveis
- Push notifications customizadas

## 🔍 Estrutura dos Projetos

```
expo-blank-ts/
├── App.tsx                    # Componente principal com SDK
├── screens/                   # Telas do app
│   ├── MainScreen/
│   └── SplashScreen/
├── interfaces/               # Interfaces TypeScript
├── android/
│   └── app/src/main/assets/
│       └── siprocal-config.json  # Config Android
├── ios/
│   └── LocalConfig.plist     # Config iOS
└── package.json              # Dependências NPM
```

## 💡 Dicas de Desenvolvimento

1. **📖 Leia a documentação** oficial antes de começar
2. **🔧 Configure os development builds** para testar funcionalidades nativas
3. **📱 Teste em dispositivos** reais para validar o SDK
4. **📝 Siga os commits** do projeto exemplo para entender cada passo
5. **🚀 Use TypeScript** para melhor experiência de desenvolvimento

## 🎮 Expo Considerations

### Development Build Necessário

Como o Siprocal SDK é um módulo nativo, você precisará criar um **development build** para testá-lo:

```bash
# Instalar Expo CLI
npm install -g @expo/cli

# Criar development build
expo install expo-dev-client
expo run:android
expo run:ios
```

### Expo Go Limitações

- ❌ O SDK **NÃO funcionará** no Expo Go
- ✅ Funciona apenas com **development builds** ou **production builds**
- 🔧 Requer configuração de módulos nativos

## 🆘 Resolução de Problemas

### Problemas Comuns

- **Expo Go não funciona**: Use development build em vez do Expo Go
- **Erro de configuração**: Verifique se os arquivos de config estão nos locais corretos
- **Build Android**: Verifique se os repositórios Maven estão configurados
- **Permissões**: Certifique-se de que as permissões foram adicionadas corretamente

### Metro Bundle Issues

Se encontrar problemas com o Metro bundler:

```bash
npx expo start --clear
```

### Onde Buscar Ajuda

- 📖 [Documentação oficial](https://developers.digitalreef.com/docs)
- 💬 [Discussões da comunidade](https://developers.digitalreef.com/discuss)
- 🔍 Examine os commits dos projetos exemplo
- 📱 [Expo Documentation](https://docs.expo.dev/)

---

**⚛️ Happy coding com React Native e Siprocal SDK!**
