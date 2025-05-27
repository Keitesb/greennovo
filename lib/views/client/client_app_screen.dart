// views/client/client_app_screen.dart
import 'package:flutter/material.dart';
import 'package:greennovo/views/client/cart_screen.dart';
import 'package:greennovo/views/client/home_screen_screen.dart';
import 'package:greennovo/views/client/ask_screen.dart';
import 'package:greennovo/views/client/settings_screen.dart';
import 'package:greennovo/widgets/client_bottom_nav_bar.dart';

class ClientAppScreen extends StatefulWidget {
  const ClientAppScreen({super.key});

  @override
  State<ClientAppScreen> createState() => _ClientAppScreenState();
}

class _ClientAppScreenState extends State<ClientAppScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),       // Tela inicial (já existente)
    const CartScreen(),       // Tela de carrinho (já existente)
    const AskScreen(),        // Tela de pedidos (já existente)
    const SettingsScreen(),   // Tela de configurações (já existente)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}