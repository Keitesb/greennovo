// lib/models/order_model.dart

import 'order_item_model.dart';
import 'user_model.dart';

class Order {
  final String id;
  final DateTime date;
  final double total;
  String status;
  final List<OrderItem> items;
  final User customer;     // Adicione este campo
  final String notes;      // Adicione este campo
  final String paymentMethod; // Adicione este campo

  Order({
    required this.id,
    required this.date,
    required this.total,
    required this.status,
    required this.items,
    required this.customer,      // Adicione este campo
    required this.notes,         // Adicione este campo
    required this.paymentMethod, // Adicione este campo
  });
}