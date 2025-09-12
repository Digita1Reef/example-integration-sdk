import 'package:flutter/material.dart';
import 'interfaces/initialization_data_interface.dart';
import 'screens/splash_screen/splash_screen.dart';
import 'screens/main_screen/main_screen.dart';

void main() {
  debugPrint("[FlutterApp] - 🚀 [MAIN] Aplicativo iniciado");
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  bool _isInitialized = false;
  InitializationData? _initializationData;

  @override
  void initState() {
    super.initState();
    debugPrint("[FlutterApp] - 🎯 [MAIN] MainApp inicializado, exibindo SplashScreen");
  }

  void _handleInitializationComplete(InitializationData data) {
    debugPrint("[FlutterApp] - 🎯 [MAIN] Inicialização concluída: $data");
    setState(() {
      _initializationData = data;
      _isInitialized = true;
    });
    debugPrint("[FlutterApp] - 📱 [MAIN] Navegando para MainScreen");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Digital Reef SDK Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: _isInitialized 
          ? MainScreen(initializationData: _initializationData)
          : SplashScreen(onInitializationComplete: _handleInitializationComplete),
      debugShowCheckedModeBanner: false,
    );
  }
}
