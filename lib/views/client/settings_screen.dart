import 'package:flutter/material.dart';
import 'package:greennovo/providers/auth_provider.dart';
import 'package:greennovo/views/splash/splash_screen.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<_SettingsOption> options = [
      _SettingsOption(icon: Icons.person, label: "Perfil", onTap: () {}),
      _SettingsOption(icon: Icons.notifications, label: "Notificações", onTap: () {}),
      _SettingsOption(icon: Icons.payment, label: "Métodos de Pagamento", onTap: () {}),
      _SettingsOption(icon: Icons.help_outline, label: "Ajuda", onTap: () {}),
      _SettingsOption(icon: Icons.logout, label: "Sair", onTap: () {
       //todo logout
        Provider.of<AuthProvider>(context,listen: false).logout();
        Navigator.pushReplacementNamed(context, '/splash');
      }),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        elevation: 0,
        title: const Text('Configurações'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        itemCount: options.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final option = options[index];
          return GestureDetector(
            onTap: option.onTap,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.05),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  )
                ],
              ),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFEAF4E4),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Icon(option.icon, color: const Color(0xFF2D722A)),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    option.label,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const Spacer(),
                  const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _SettingsOption {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  _SettingsOption({required this.icon, required this.label, required this.onTap});
}