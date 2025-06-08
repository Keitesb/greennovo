import 'package:greennovo/models/order_item_model.dart';
import 'package:greennovo/models/user_model.dart';

class Order {
  final String id;
  final DateTime date;
  final double total;
  String status;
  final List<OrderItem> items;
  final User customer;
  final String notes;
  final String paymentMethod;

  Order({
    required this.id,
    required this.date,
    required this.total,
    required this.status,
    required this.items,
    required this.customer,
    required this.notes,
    required this.paymentMethod,
  });

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'],
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      total: map['total'],
      status: map['status'],
      items: List<OrderItem>.from(map['items'].map((item) => OrderItem.fromMap(item))),
      customer: User.fromMap(map['customer']),
      notes: map['notes'],
      paymentMethod: map['payment_method'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date.millisecondsSinceEpoch,
      'total': total,
      'status': status,
      'items': items.map((item) => item.toMap()).toList(),
      'customer': customer.toMap(),
      'notes': notes,
      'payment_method': paymentMethod,
    };
  }
}