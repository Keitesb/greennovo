// lib/views/supplier/vendor_orders_screen.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:greennovo/providers/vendor_order_provider.dart';
import 'package:greennovo/models/order_model.dart';
import 'package:greennovo/views/supplier/order_details_screen.dart';

class VendorOrdersScreen extends StatefulWidget {
  const VendorOrdersScreen({super.key});

  @override
  State<VendorOrdersScreen> createState() => _VendorOrdersScreenState();
}

class _VendorOrdersScreenState extends State<VendorOrdersScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<VendorOrderProvider>(context, listen: false)
        .fetchVendorOrders('mockVendorId');
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<VendorOrderProvider>(
      builder: (context, provider, _) {
        final isLoading = provider.isLoading;
        final error = provider.errorMessage;
        final orders = provider.orders;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Encomendas'),
            centerTitle: true,
            elevation: 0,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : error != null
                ? Center(
              child: Text(
                error!,
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
            )
                : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                const Text(
                  'Histórico de Encomendas',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: orders.isEmpty
                      ? const Center(
                    child: Text(
                      "Nenhuma encomenda encontrada.",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  )
                      : ListView.builder(
                    itemCount: orders.length,
                    itemBuilder: (context, index) {
                      final order = orders[index];
                      return _OrderCard(order: order);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _OrderCard extends StatelessWidget {
  final Order order;

  const _OrderCard({required this.order});

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd/MM/yyyy');
    final formattedDate = dateFormat.format(order.date);

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Encomenda #${order.id}',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: _statusColor(order.status),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    _statusText(order.status),
                    style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Cliente: ${order.customer.name}',
              style: TextStyle(color: Colors.grey[700], fontSize: 14),
            ),
            const SizedBox(height: 6),
            Text(
              'Data: $formattedDate',
              style: TextStyle(color: Colors.grey[600], fontSize: 14),
            ),
            const SizedBox(height: 6),
            Text(
              'Total: MZN ${order.total.toStringAsFixed(2)}',
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            if (order.notes.isNotEmpty) ...[
              const SizedBox(height: 6),
              Text(
                'Observações: ${order.notes}',
                style: TextStyle(color: Colors.grey[800], fontSize: 14),
              ),
            ],
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.green[700],
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: const BorderSide(color: Colors.green),
                  ),
                ),
                onPressed: () => _showOrderDetails(context, order),
                child: const Text('Ver Detalhes', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'pending':
        return Colors.orange;
      case 'preparing':
        return Colors.blue;
      case 'shipped':
        return Colors.purple;
      case 'delivered':
        return Colors.green;
      default:
        return Colors.grey;
    }
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

  void _showOrderDetails(BuildContext context, Order order) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => OrderDetailScreen(orderId: order.id)),
    );
  }
}