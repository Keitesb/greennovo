import 'package:greennovo/models/cart_item_model.dart';

class Order {
  final String id;
  final String date;
  final List<CartItem> items;
  final double total;
  final String status;

  const Order({
    required this.id,
    required this.date,
    required this.items,
    required this.total,
    required this.status,
  });
}