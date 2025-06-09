// views/main_app_screen.dart
import 'package:flutter/material.dart';
import 'package:greennovo/views/client/client_app_screen.dart';
import 'package:greennovo/views/supplier/supplier_home_screen.dart';
import 'package:provider/provider.dart';
import 'package:greennovo/providers/auth_provider.dart';

class MainAppScreen extends StatelessWidget {
  const MainAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Provider.of<AuthProvider>(context);

    final email=authController.currentUser!.email;

    if (email.endsWith('@greengrocer.mz')) {
      return const SupplierHomeScreen();
    } else {
      return const ClientAppScreen();
    }

  }
}