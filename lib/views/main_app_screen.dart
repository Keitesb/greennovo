// views/main_app_screen.dart
import 'package:flutter/material.dart';
import 'package:greennovo/views/client/client_app_screen.dart';
import 'package:greennovo/views/supplier/supplier_app_screen.dart';
import 'package:provider/provider.dart';
import 'package:greennovo/controllers/auth_controller.dart';
import 'package:greennovo/views/client/home_screen_screen.dart';

class MainAppScreen extends StatelessWidget {
  const MainAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Provider.of<AuthController>(context);

    if (authController.isClient) {
      return const ClientAppScreen();
    } else if (authController.isSupplier) {
      return const SupplierAppScreen();
    } else {
      // Isso não deve acontecer, pois o MainAppScreen só é chamado após login
      return const Scaffold(body: Center(child: Text('Erro: Tipo de usuário desconhecido')));
    }
  }
}