# Siprocal SDK - Projetos de Exemplo de Integração

Este repositório contém projetos de exemplo que demonstram como integrar o **Siprocal SDK** em diferentes tecnologias e versões.

## 📋 Sobre o Projeto

O Siprocal SDK é uma solução de análise e engajamento mobile que oferece insights valiosos sobre o comportamento dos usuários. Este repositório foi criado para fornecer exemplos práticos de como implementar o SDK em projetos reais.

## 🏗️ Estrutura do Projeto

O projeto está organizado por versões do SDK e tecnologias:

```
example-integration-sdk/
├── version-4/                 # Exemplos para SDK v4 (documentação separada)
│   ├── react-native/
│   └── flutter/
└── version-5/                 # Exemplos para SDK v5 ✨
    ├── flutter/
    │   └── empty_example/     # Projeto Flutter de exemplo
    └── react-native/
        └── expo-blank-ts/     # Projeto React Native com Expo
```

## 🚀 Versões Disponíveis

### Versão 5 (Atual) ✨

- **Flutter**: Projeto `empty_example` com integração completa
- **React Native**: Projeto `expo-blank-ts` com TypeScript e Expo

### Versão 4

- Documentação e exemplos serão atualizados posteriormente

## 📚 Documentação Oficial

- **Documentação Geral**: [https://developers.digitalreef.com/docs](https://developers.digitalreef.com/docs)
- **React Native**: [Guia de Integração](https://developers.digitalreef.com/docs/integrating-siprocal-sdk-1)
- **Flutter**: [Guia de Integração](https://developers.digitalreef.com/docs/integrating-siprocal-sdk)

## 🛠️ Como Usar

1. **Escolha a versão do SDK** que você deseja usar
2. **Navegue até a tecnologia** desejada (Flutter ou React Native)
3. **Acesse o projeto de exemplo** correspondente
4. **Siga o README específico** do projeto para instruções detalhadas

## ⚠️ Notas Importantes

### 🔧 Implementação Técnica

- **Flutter**: Usa variante **Helios** (`siprocalsdk_helios: 5.8.1`)
- **React Native**: Usa variante **Chronos** (`com.digitalreef.phoenix:chronos:5.8.1`)
- **Auto-inicialização**: SDK v5 se inicializa automaticamente
- **Verificação**: `getSdkInformation()` usado para verificar status e obter dados

### 📋 Características dos Projetos

- ❌ **Firebase/FCM**: Os projetos NÃO incluem integração com Firebase Cloud Messaging
- ❌ **Recursos Opcionais**: Funcionalidades opcionais do SDK não foram implementadas
- ✅ **Integração Básica**: Foco na implementação mínima necessária para o funcionamento

## 📝 Commits Explicativos

Cada projeto foi desenvolvido com commits que explicam cada passo da integração, facilitando o entendimento do processo:

- Configuração inicial do projeto
- Adição das dependências do SDK
- Configuração Android
- Configuração iOS
- Implementação da inicialização
- Testes e validação

## 🔧 Tecnologias Suportadas

| Tecnologia   | Versão | Status        | Exemplo         |
| ------------ | ------ | ------------- | --------------- |
| Flutter      | v5     | ✅ Disponível | `empty_example` |
| React Native | v5     | ✅ Disponível | `expo-blank-ts` |

## 📞 Suporte

Para dúvidas específicas sobre a integração:

- 📖 Consulte a [documentação oficial](https://developers.digitalreef.com/docs)
- 💬 Acesse as [discussões da comunidade](https://developers.digitalreef.com/discuss)

---

**Desenvolvido para demonstrar a integração do Siprocal SDK de forma prática e educativa.**
