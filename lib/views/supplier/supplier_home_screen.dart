import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:greennovo/providers/auth_provider.dart';
import 'package:greennovo/views/supplier/product.dart';
import 'package:provider/provider.dart';
import 'package:greennovo/providers/supplier_home_controller.dart';
import 'package:greennovo/views/supplier/product_screen.dart';
import 'package:greennovo/views/supplier/vendor_orders_screen.dart';
import 'package:greennovo/views/supplier/notification_screen.dart';
import 'package:greennovo/views/supplier/add_product_screen.dart';

class SupplierHomeScreen extends StatelessWidget {
  const SupplierHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<SupplierHomeController>(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final isWide = screenWidth >= 600;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: _buildAppBar(context),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final horizontalPadding = isWide ? constraints.maxWidth * 0.1 : 20.0;
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                _buildWelcomeHeader(),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: _buildActionCard(
                        icon: Icons.local_shipping,
                        label: 'Entregas do dia',
                        color: const Color(0xFF4285F4),
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Entregas ainda não implementadas.')),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildActionCard(
                        icon: Icons.shopping_cart,
                        label: 'Encomendas',
                        color: const Color(0xFF34A853),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => VendorOrdersScreen()),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                _buildSectionHeader('Menu Principal'),
                const SizedBox(height: 16),
                _buildMenuOptions(context, isWide),
                const SizedBox(height: 40),
              ],
            ),
          );
        },
      ),
      floatingActionButton: _buildFloatingActionButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }


  PreferredSizeWidget _buildAppBar(BuildContext context) {

    final authController = Provider.of<AuthProvider>(context);
    final userName = authController.currentUser?.name ?? '';
    final initial = userName.isNotEmpty ? userName[0].toUpperCase() : 'G';
    print("nome: $userName");


    return AppBar(
      backgroundColor: Colors.white,
      elevation: 1,
      toolbarHeight: 80,
      title: Row(
        children: [
          const Text.rich(
            TextSpan(
              text: 'Green',
              style: TextStyle(color: Color(0xFF4CAF50), fontWeight: FontWeight.bold, fontSize: 22),
              children: [TextSpan(text: 'grocer', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w500))],
            ),
          ),
          const Spacer(),
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.grey[200],
            child:  Text(initial, style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Bem-vindo, Fornecedor',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.grey[800]),
        ),
        const SizedBox(height: 6),
        Text(
          'Gerencie suas entregas e produtos',
          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
        ),
      ],
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 4,
        shadowColor: Colors.black.withOpacity(0.05),
        child: Container(
          height: 140,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 36, color: color),
              ),
              const SizedBox(height: 16),
              Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.grey[800]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String text) {
    return Text(
      text,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.grey[700]),
    );
  }

  Widget _buildMenuOptions(BuildContext context, bool isWide) {
    final items = [
      _MenuItem(
        icon: Icons.inventory_2,
        title: 'Produtos',
        color: const Color(0xFFFBBC05),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const ProdutosScreen()),
        ),
      ),
      _MenuItem(
        icon: Icons.notifications,
        title: 'Notificações',
        color: const Color(0xFFEA4335),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const NotificationScreen()),
        ),
      ),
      _MenuItem(
        icon: Icons.settings,
        title: 'Definições',
        color: const Color(0xFF673AB7),
        onTap: () {},
      ),
      _MenuItem(
        icon: Icons.logout,
        title: 'Sair',
        color: Colors.grey,
        onTap: () => {
          Provider.of<AuthProvider>(context,listen: false).logout(),
          Navigator.pushReplacementNamed(context, '/splash')
        },
      ),
    ];

    if (isWide) {
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: items.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 5,
        ),
        itemBuilder: (context, index) {
          final item = items[index];
          return _buildMenuTile(item);
        },
      );
    } else {
      return Column(
        children: items
            .map((item) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _buildMenuTile(item),
        ))
            .toList(),
      );
    }
  }

  Widget _buildMenuTile(_MenuItem item) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8)],
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(color: item.color.withOpacity(0.1), shape: BoxShape.circle),
          child: Icon(item.icon, color: item.color, size: 24),
        ),
        title: Text(item.title, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
        trailing: Stack(
          alignment: Alignment.center,
          children: [
            const Icon(Icons.chevron_right, color: Colors.grey),
            if (item.showBadge)
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                ),
              ),
          ],
        ),
        onTap: item.onTap,
      ),
    );
  }


  Widget _buildFloatingActionButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: FloatingActionButton(
        backgroundColor: const Color(0xFF4CAF50),
        elevation: 18,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: const Icon(Icons.add, size: 28, color: Colors.white),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddProductScreen()),
          );
        },
      ),
    );
  }}

class _MenuItem {
  final IconData icon;
  final String title;
  final Color color;
  final VoidCallback onTap;
  final bool showBadge;

  _MenuItem({
    required this.icon,
    required this.title,
    required this.color,
    required this.onTap,
    this.showBadge = false,
  });
}