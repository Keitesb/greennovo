// lib/views/supplier/notification_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:greennovo/providers/vendor_order_provider.dart';
import 'package:greennovo/models/order_model.dart';
import 'package:greennovo/views/supplier/order_details_screen.dart';
import 'package:intl/intl.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notificações'),
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black87),
        titleTextStyle: const TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xFFF4F4F4),
      body: Consumer<VendorOrderProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          final orders = provider.orders;
          if (orders.isEmpty) {
            return const Center(
              child: Text(
                'Nenhuma notificação no momento.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 16),
            itemCount: orders.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final order = orders[index];
              final dateFormat = DateFormat('dd/MM/yyyy');
              final dateText = dateFormat.format(order.date);
              return ListTile(
                contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.notifications, color: Colors.orange),
                ),
                title: Text(
                  'Pedido #${order.id}',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                subtitle: Text(
                  'Status: ${_statusText(order.status)} • $dateText',
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          OrderDetailScreen(orderId: order.id),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  String _statusText(String status) {
    switch (status) {
      case 'pending':
        return 'Pendente';
      case 'preparing':
        return 'Em preparação';
      case 'shipped':
        return 'Enviado';
      case 'delivered':
        return 'Entregue';
      default:
        return 'Desconhecido';
    }
  }
}