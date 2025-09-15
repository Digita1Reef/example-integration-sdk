# Empty Example - Flutter + Siprocal SDK v5

Este é um projeto Flutter **"empty"** (mínimo) que demonstra a integração completa do **Siprocal SDK v5** usando a variante **Helios**.

## 🎯 Sobre Este Projeto

Este exemplo foi criado com o objetivo de mostrar a implementação mais básica e limpa possível do Siprocal SDK em um app Flutter, servindo como referência para desenvolvedores que querem integrar o SDK em seus próprios projetos.

## 📦 Configuração do Projeto

### Dependências Principais

- **Flutter SDK**: ^3.9.2
- **siprocalsdk_helios**: 5.8.1

### Arquivos de Configuração

- ✅ `android/app/src/main/assets/siprocal-config.json` - Configuração Android
- ✅ `ios/LocalConfig.plist` - Configuração iOS

## 🏗️ Estrutura do Projeto

```
lib/
├── main.dart                    # Ponto de entrada do app
├── interfaces/
│   └── initialization_data_interface.dart  # Interface de dados de inicialização
└── screens/
    ├── splash_screen/
    │   └── splash_screen.dart   # Tela inicial com inicialização do SDK
    └── main_screen/
        └── main_screen.dart     # Tela principal do app
```

## 🚀 Como Executar

### Pré-requisitos

- Flutter SDK 3.9.2 ou superior
- Android Studio com Android SDK
- Xcode (para iOS)

### Passos

1. **Clone e navegue** para o projeto:

   ```bash
   cd version-5/flutter/empty_example/
   ```

2. **Instale as dependências**:

   ```bash
   flutter pub get
   ```

3. **Execute no Android**:

   ```bash
   flutter run
   ```

4. **Execute no iOS**:
   ```bash
   flutter run -d ios
   ```

## 🔧 Implementação do SDK

### 1. Verificação do SDK

O SDK v5 se **auto-inicializa** automaticamente. O método `getSdkInformation()` é usado para verificar se está funcionando e obter informações:

```dart
import 'package:siprocalsdk_helios/siprocalsdk_helios.dart';

class _SplashScreenState extends State<SplashScreen> {
  final _siprocalPlugin = SiprocalsdkHelios();

  Future<void> _initializeSiprocalSDK() async {
    try {
      debugPrint("[FlutterApp] - 🚀 [SplashScreen] Obtendo informações do SDK...");

      // Verificando disponibilidade do módulo
      _updateProgress(10, "[FlutterApp] - [SplashScreen] Verificando módulo SDK siprocalsdk-helios...");
      await _delay(1000);

      // Obtendo informações do SDK (que já se auto-inicializou)
      _updateProgress(50, "[FlutterApp] - [SplashScreen] Obtendo informações do SDK...");
      String? sdkInfo = await _siprocalPlugin.getSdkInformation();
      debugPrint("[FlutterApp] - ✅ [SplashScreen] Informações do SDK obtidas: $sdkInfo");

      // Finalizando inicialização
      _updateProgress(100, "Inicialização completa!");
      await _delay(1000);

      // Navegar para a tela principal
      final initData = InitializationData(
        success: true,
        data: sdkInfo != null ? jsonDecode(sdkInfo) : null,
        timestamp: DateTime.now().toIso8601String(),
      );

      widget.onInitializationComplete(initData);

    } catch (error) {
      debugPrint("[FlutterApp]- ❌ [SplashScreen] Erro durante inicialização: $error");

      // Mesmo com erro, navegar para a tela principal
      final initData = InitializationData(
        success: false,
        error: error.toString(),
        timestamp: DateTime.now().toIso8601String(),
      );

      widget.onInitializationComplete(initData);
    }
  }
}
```

### 2. Configuração Android

No arquivo `android/app/build.gradle.kts`:

```kotlin
dependencies {
    implementation("com.digitalreef.phoenix:helios:5.8.1")
}
```

### 3. Fluxo da Aplicação

1. **SDK Auto-inicialização**: O SDK se inicializa automaticamente ao ser carregado
2. **SplashScreen**: Exibe animações e verifica status do SDK
3. **Progresso Visual**: Barra de progresso com etapas visuais
4. **Verificação**: `getSdkInformation()` confirma que está funcionando
5. **Transição**: Após verificação, navega para MainScreen
6. **MainScreen**: Exibe status da verificação e dados do SDK

### 4. Tratamento de Erros

O projeto inclui tratamento adequado de erros durante a verificação:

- ✅ Try-catch para capturar erros
- ✅ Logs informativos para debug
- ✅ Fallback em caso de falha
- ✅ Navegação continua mesmo com erro

## 📱 Recursos Implementados

### ✅ Implementado

- ✅ Auto-inicialização do SDK (automática)
- ✅ Verificação de status com `getSdkInformation()`
- ✅ Configuração Android com `siprocal-config.json`
- ✅ Configuração iOS com `LocalConfig.plist`
- ✅ Interface clean com Material Design 3
- ✅ Tratamento de erros na verificação
- ✅ Logs detalhados para debugging

### ❌ Não Implementado (Propositalmente)

- ❌ Firebase Cloud Messaging
- ❌ Permissões avançadas (localização, Bluetooth)
- ❌ Configurações de dados sensíveis
- ❌ Customizações visuais avançadas

## 🧩 Personalização

### Variante do SDK

Este projeto usa a variante **Helios**. Para usar outra variante:

1. Atualize o `pubspec.yaml`:

   ```yaml
   dependencies:
     siprocalsdk_<sua_variante>: <versao>
   ```

2. Atualize os imports:
   ```dart
   import 'package:siprocalsdk_<sua_variante>/siprocalsdk_<sua_variante>.dart';
   ```

### Configurações

- **Android**: Edite `android/app/src/main/assets/siprocal-config.json`
- **iOS**: Edite `ios/LocalConfig.plist`

## 📊 Histórico de Commits

Este projeto foi desenvolvido com commits explicativos que mostram cada passo da integração. Você pode ver o histórico completo com:

```bash
git log --oneline --grep="version-5.*flutter.*empty_example"
```

**Sequência real de desenvolvimento:**

1. **`723c5bc`** - 🎬 `[version-5 | flutter | empty_example] Inicializando o projeto flutter`
2. **`66a05e4`** - 📦 `[version-5 | flutter | empty_example] Instalando pacote Siprocal SDK Helios 5.8.1 no Flutter`
3. **`e77f273`** - 🔧 `[version-5 | flutter | empty_example] Adicionando repositorio maven jitpack no Android`
4. **`6f69341`** - 🤖 `[version-5 | flutter | empty_example] Incluindo dependencia com.digitalreef.phoenix no Android`
5. **`65bf0f6`** - 📋 `[version-5 | flutter | empty_example] Incluindo arquivo siprocal-config.json e LocalConfig.plist`
6. **`2ce1184`** - 🚀 `[version-5 | flutter | empty_example] Incluindo MainApplication no Android nativo`
7. **`b883c13`** - 🛡️ `[version-5 | flutter | empty_example] Adicionando proguards`
8. **`ac22698`** - 🔐 `[version-5 | flutter | empty_example] Incluindo permissões obrigatorias`
9. **`ea35a33`** - � `[version-5 | flutter | empty_example] Incluindo permissões exclusivas da versão helios ou hestia`
10. **`de43804`** - ⚠️ `[HACK - SOMENTE DESENVOLVIMENTO] Alterando applicationId para funcionar com package da Siprocal`
11. **`2df4a44`** - ✅ `[version-5 | flutter | empty_example] Incluindo Inicialização do SDK em Splash Screen`

## 🐛 Debugging

### Logs Importantes

O projeto inclui logs detalhados que ajudam no debugging:

```dart
debugPrint("[FlutterApp] - 🚀 [MAIN] Aplicativo iniciado");
debugPrint("[FlutterApp] - 🎯 [SPLASH] Inicializando Siprocal SDK...");
debugPrint("[FlutterApp] - ✅ [SPLASH] SDK inicializado com sucesso!");
```

### Problemas Comuns

1. **SDK não inicializa**: Verifique se os arquivos de configuração estão nos locais corretos
2. **Erro de build Android**: Confirme que os repositórios Maven estão configurados
3. **Erro de build iOS**: Verifique se o LocalConfig.plist foi adicionado ao target

## 📚 Referências

- [Documentação Flutter + Siprocal](https://developers.digitalreef.com/docs/integrating-siprocal-sdk)
- [Configuração Android](https://developers.digitalreef.com/docs/android-integration)
- [Configuração iOS](https://developers.digitalreef.com/docs/ios-integration)
- [Métodos Adicionais Dart](https://developers.digitalreef.com/docs/additional-methods-dart)

## 💡 Próximos Passos

Após executar este exemplo com sucesso, você pode:

1. **Integrar em seu projeto** seguindo os mesmos passos
2. **Adicionar recursos** como push notifications
3. **Explorar APIs avançadas** do SDK
4. **Customizar** a interface conforme sua necessidade

---

**🎯 Este projeto serve como base sólida para qualquer integração do Siprocal SDK em Flutter!**
