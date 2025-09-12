import 'package:flutter/material.dart';
import '../../interfaces/initialization_data_interface.dart';

class MainScreen extends StatelessWidget {
  final InitializationData? initializationData;

  const MainScreen({super.key, this.initializationData});

  @override
  Widget build(BuildContext context) {
    debugPrint("[FlutterApp] - 🎯 [MainScreen] Tela principal carregada com dados: $initializationData");
    
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Open up main.dart to start working on your app!",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
              
              if (initializationData != null) ...[
                const SizedBox(height: 40),
                _buildInitializationStatus(),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInitializationStatus() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: initializationData!.success ? Colors.green : Colors.red,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                initializationData!.success ? Icons.check_circle : Icons.error,
                color: initializationData!.success ? Colors.green : Colors.red,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                initializationData!.success 
                    ? "SDK Inicializado com Sucesso" 
                    : "Erro na Inicialização do SDK",
                style: TextStyle(
                  color: initializationData!.success ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          if (initializationData!.success && initializationData!.data != null) ...[
            const Text(
              "Dados do SDK:",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                initializationData!.data.toString(),
                style: const TextStyle(
                  color: Colors.green,
                  fontSize: 12,
                  fontFamily: 'monospace',
                ),
              ),
            ),
          ],
          
          if (!initializationData!.success && initializationData!.error != null) ...[
            const Text(
              "Erro:",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.red[900]?.withOpacity(0.2),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                initializationData!.error!,
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 12,
                ),
              ),
            ),
          ],
          
          const SizedBox(height: 12),
          
          Text(
            "Timestamp: ${initializationData!.timestamp}",
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}