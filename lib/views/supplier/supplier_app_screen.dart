// views/supplier/supplier_home_screen.dart
import 'package:flutter/material.dart';
import 'package:greennovo/widgets/supplier_bottom_nav_bar.dart';

class SupplierAppScreen extends StatefulWidget {
  const SupplierAppScreen({super.key});

  @override
  State<SupplierAppScreen> createState() => _SupplierAppScreenState();
}

class _SupplierAppScreenState extends State<SupplierAppScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const Center(child: Text('Tela de Pedidos para Fornecedor')),
    const Center(child: Text('Tela de Produtos para Fornecedor')),
    const Center(child: Text('Tela de Estatísticas')),
    const Center(child: Text('Configurações do Fornecedor')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: SupplierBottomNavBar(
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