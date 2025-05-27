import 'package:flutter/material.dart';

class NotificationDrawer extends StatelessWidget {
  const NotificationDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white.withOpacity(1),
      child: ListView(
        children: [
          const DrawerHeader(
            child: Text(
              'Notificações',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          const ListTile(
            leading: Icon(Icons.message, color: Colors.black),
            title: Text(
              'Nova mensagem de promoção: Coletar Pedido 032',
              style: TextStyle(color: Colors.black),
            ),
          ),
          const Divider(),
          const ListTile(
            leading: Icon(Icons.delivery_dining, color: Colors.black),
            title: Text(
              'Seu pedido de referencia 002 está a caminho',
              style: TextStyle(color: Colors.black),
            ),
          ),
          const Divider(),
          const ListTile(
            leading: Icon(Icons.delivery_dining, color: Colors.black),
            title: Text(
              'Seu pedido de referencia 032 está a caminho',
              style: TextStyle(color: Colors.black),
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
            child: TextButton(
              onPressed: () => Navigator.of(context).pop(),
              style: TextButton.styleFrom(foregroundColor: Colors.black),
              child: const Text(
                'Fechar',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}