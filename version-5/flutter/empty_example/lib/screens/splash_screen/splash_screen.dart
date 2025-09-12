import 'package:flutter/material.dart';
import 'dart:convert';
import '../../interfaces/initialization_data_interface.dart';
import 'package:siprocalsdk_helios/siprocalsdk_helios.dart';

class SplashScreen extends StatefulWidget {
  final Function(InitializationData) onInitializationComplete;

  const SplashScreen({super.key, required this.onInitializationComplete});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  final _siprocalPlugin = SiprocalsdkHelios();
  
  double _progress = 0.0;
  String _statusText = "Carregando...";
  
  late AnimationController _fadeController;
  late AnimationController _scaleController;
  late AnimationController _progressController;
  late AnimationController _dotsController;
  
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _progressAnimation;
  
  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startInitialAnimations();
    _initializeSiprocalSDK();
  }

  void _initializeAnimations() {
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _progressController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    
    _dotsController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );
    
    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
    );
    
    _progressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _progressController, curve: Curves.easeInOut),
    );
  }

  void _startInitialAnimations() {
    _fadeController.forward();
    _scaleController.forward();
    _dotsController.repeat();
  }

  Future<void> _initializeSiprocalSDK() async {
    try {
      debugPrint("[FlutterApp] - 🚀 [SplashScreen] Obtendo informações do SDK...");
      
      // Etapa 1: Verificando disponibilidade do módulo
      _updateProgress(
        10,
        "[FlutterApp] - [SplashScreen] Verificando módulo SDK siprocalsdk-helios..."
      );
      
      await _delay(1000);

      // Etapa 2: Obtendo informações do SDK
      _updateProgress(50, "[FlutterApp] - [SplashScreen] Obtendo informações do SDK...");
      
      String? sdkInfo = await _siprocalPlugin.getSdkInformation();
      debugPrint("[FlutterApp] - ✅ [SplashScreen] Informações do SDK obtidas: $sdkInfo");

      await _delay(1000);

      // Etapa 3: Finalizando inicialização
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

      _updateProgress(100, "Erro na inicialização");
      await _delay(1000);

      // Mesmo com erro, navegar para a tela principal
      final initData = InitializationData(
        success: false,
        error: error.toString(),
        timestamp: DateTime.now().toIso8601String(),
      );
      
      widget.onInitializationComplete(initData);
    }
  }

  Future<void> _delay(int milliseconds) {
    return Future.delayed(Duration(milliseconds: milliseconds));
  }

  void _updateProgress(double newProgress, String newStatusText) {
    setState(() {
      _progress = newProgress;
      _statusText = newStatusText;
    });

    _progressController.animateTo(newProgress / 100);
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _scaleController.dispose();
    _progressController.dispose();
    _dotsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF1E3A8A), // Deep blue
              Color(0xFF1E40AF), // Slightly lighter blue
            ],
          ),
        ),
        child: SafeArea(
          child: AnimatedBuilder(
            animation: Listenable.merge([_fadeAnimation, _scaleAnimation]),
            builder: (context, child) {
              return Opacity(
                opacity: _fadeAnimation.value,
                child: Transform.scale(
                  scale: _scaleAnimation.value,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Logo/Icon Section
                        _buildLogoSection(),
                        
                        const SizedBox(height: 60),
                        
                        // Progress Section
                        _buildProgressSection(),
                        
                        const SizedBox(height: 40),
                        
                        // Loading Animation
                        _buildLoadingDots(),
                        
                        const Spacer(),
                        
                        // Footer
                        _buildFooter(),
                        
                        const SizedBox(height: 50),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildLogoSection() {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 20),
          child: const Text(
            "🛡️",
            style: TextStyle(fontSize: 80),
          ),
        ),
        const Text(
          "Digital Reef SDK",
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        Text(
          "Inicializando sistema de análise",
          style: TextStyle(
            fontSize: 16,
            color: Colors.white.withOpacity(0.8),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildProgressSection() {
    return Column(
      children: [
        Text(
          _statusText,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        
        // Progress Bar
        Container(
          width: double.infinity,
          height: 6,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(3),
          ),
          child: AnimatedBuilder(
            animation: _progressAnimation,
            builder: (context, child) {
              return Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: MediaQuery.of(context).size.width * 
                         (_progressAnimation.value * 0.8), // 0.8 for padding
                  height: 6,
                  decoration: BoxDecoration(
                    color: const Color(0xFF10B981), // Green
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              );
            },
          ),
        ),
        
        const SizedBox(height: 15),
        
        // Progress Percentage
        Text(
          "${_progress.toInt()}%",
          style: TextStyle(
            fontSize: 16,
            color: Colors.white.withOpacity(0.9),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildLoadingDots() {
    return AnimatedBuilder(
      animation: _dotsController,
      builder: (context, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(3, (index) {
            final delay = index * 2;
            final animationValue = (_dotsController.value + delay) % 1.0;
            final scale = 0.5 + (0.5 * (1.0 - (animationValue - 0.5).abs() * 2));
            
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 6),
              child: Transform.scale(
                scale: scale,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: const BoxDecoration(
                    color: Color(0xFF10B981), // Green
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }

  Widget _buildFooter() {
    return Column(
      children: [
        Text(
          "Powered by Digital Reef",
          style: TextStyle(
            fontSize: 14,
            color: Colors.white.withOpacity(0.9),
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          "SDK v4.28.7 • Flutter 3.27.0",
          style: TextStyle(
            fontSize: 12,
            color: Colors.white.withOpacity(0.7),
          ),
        ),
      ],
    );
  }
}