// views/main_app_screen.dart
import 'package:flutter/material.dart';
import 'package:greennovo/views/client/client_app_screen.dart';
import 'package:greennovo/views/supplier/supplier_home_screen.dart';
import 'package:provider/provider.dart';
import 'package:greennovo/providers/auth_provider.dart';
import 'package:greennovo/views/client/home_screen_screen.dart';

class MainAppScreen extends StatelessWidget {
  const MainAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Provider.of<AuthProvider>(context);

    if (authController.isClient) {
      return const ClientAppScreen();
    } else if (authController.isSupplier) {
      return const SupplierHomeScreen();
    } else {
      // Isso não deve acontecer, pois o MainAppScreen só é chamado após login
      return const Scaffold(body: Center(child: Text('Erro: Tipo de usuário desconhecido')));
    }
  }
}