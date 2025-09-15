# Flutter - Siprocal SDK v5

Esta pasta contém exemplos de integração do **Siprocal SDK v5** para projetos **Flutter**.

## 🎯 Sobre a Integração Flutter

O Siprocal SDK para Flutter oferece uma integração nativa completa, permitindo que desenvolvedores Flutter aproveitem todos os recursos de análise e engajamento da plataforma.

## 📂 Projetos Disponíveis

### [`empty_example/`](./empty_example/)

Projeto Flutter limpo criado especificamente para demonstrar a integração básica do Siprocal SDK.

**Características:**

- ✅ Projeto Flutter "vazio" (minimal boilerplate)
- ✅ Integração completa do SDK v5
- ✅ Configuração Android e iOS
- ✅ Exemplo de verificação do SDK
- ✅ Commits explicativos de cada passo

## 🚀 Começando Rapidamente

1. **Navegue para o projeto**:

   ```bash
   cd empty_example/
   ```

2. **Instale as dependências**:

   ```bash
   flutter pub get
   ```

3. **Execute o projeto**:
   ```bash
   flutter run
   ```

## 📖 Documentação de Referência

### Guias Oficiais Flutter

- 📚 [**Integração Principal**](https://developers.digitalreef.com/docs/integrating-siprocal-sdk) - Como adicionar o SDK ao projeto
- 🤖 [**Configuração Android**](https://developers.digitalreef.com/docs/android-integration) - Setup específico para Android
- 🍎 [**Configuração iOS**](https://developers.digitalreef.com/docs/ios-integration) - Setup específico para iOS
- 🛠️ [**Métodos Adicionais**](https://developers.digitalreef.com/docs/additional-methods-dart) - APIs avançadas em Dart
- ℹ️ [**Informações Extras**](https://developers.digitalreef.com/docs/additional-information-1) - Dicas e troubleshooting

## 🔧 Processo de Integração

### 1. Adicionar Dependência

```yaml
dependencies:
  siprocalsdk_<variant>: <version>
```

### 2. Configuração Android

- Adicionar `siprocal-config.json` em `android/app/src/main/assets/`
- Configurar `build.gradle` com repositórios necessários
- Atualizar `AndroidManifest.xml` com permissões

### 3. Configuração iOS

- Adicionar `LocalConfig.plist` ao projeto iOS
- Configurar permissões no `Info.plist`
- Atualizar configurações do Xcode

### 4. Verificação do SDK

```dart
import 'package:siprocalsdk_helios/siprocalsdk_helios.dart';

// O SDK se auto-inicializa. Apenas verificamos se está funcionando:
final _siprocalPlugin = SiprocalsdkHelios();
String? sdkInfo = await _siprocalPlugin.getSdkInformation();
```

## ⚙️ Requisitos Técnicos

- **Flutter**: 3.0.0 ou superior
- **Dart**: 3.0.0 ou superior
- **Android**: API level 21 (Android 5.0) ou superior
- **iOS**: 11.0 ou superior

## 📱 Plataformas Suportadas

| Plataforma | Status            | Notas               |
| ---------- | ----------------- | ------------------- |
| Android    | ✅ Suportado      | API 21+             |
| iOS        | ✅ Suportado      | iOS 11.0+           |
| Web        | ❓ Verificar docs | Pode ter limitações |
| Desktop    | ❓ Verificar docs | Pode ter limitações |

## 🚨 Importantes Considerações

### ✅ O que está incluído:

- Configuração básica do SDK
- Inicialização adequada
- Configurações mínimas necessárias
- Permissões básicas

### ❌ O que NÃO está incluído:

- Integração com Firebase Cloud Messaging
- Configurações avançadas opcionais
- Recursos de coleta de dados sensíveis
- Customizações visuais

## 🔍 Estrutura dos Projetos

```
empty_example/
├── lib/
│   ├── main.dart              # Ponto de entrada com SDK
│   ├── interfaces/            # Interfaces personalizadas
│   └── screens/               # Telas do app
├── android/
│   └── app/src/main/assets/
│       └── siprocal-config.json  # Config Android
├── ios/
│   └── LocalConfig.plist      # Config iOS
└── pubspec.yaml               # Dependências Flutter
```

## 💡 Dicas de Desenvolvimento

1. **📖 Leia a documentação** oficial antes de começar
2. **🔧 Configure os arquivos** de configuração adequadamente
3. **📱 Teste em dispositivos** reais para validar funcionalidades
4. **📝 Siga os commits** do projeto exemplo para entender cada passo
5. **🚀 Implemente incrementalmente** uma funcionalidade por vez

## 🆘 Resolução de Problemas

### Problemas Comuns

- **Erro de configuração**: Verifique se os arquivos de config estão nos locais corretos
- **Permissões**: Certifique-se de que as permissões foram adicionadas corretamente
- **Build Android**: Verifique se os repositórios Maven estão configurados
- **Build iOS**: Confirme se o LocalConfig.plist está adicionado ao target

### Onde Buscar Ajuda

- 📖 [Documentação oficial](https://developers.digitalreef.com/docs)
- 💬 [Discussões da comunidade](https://developers.digitalreef.com/discuss)
- 🔍 Examine os commits dos projetos exemplo

---

**💻 Happy coding com Flutter e Siprocal SDK!**
