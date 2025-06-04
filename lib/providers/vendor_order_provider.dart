// lib/providers/vendor_order_provider.dart

import 'package:flutter/material.dart';
import 'package:greennovo/models/order_model.dart';
import 'package:greennovo/models/user_model.dart';
import 'package:greennovo/models/order_item_model.dart';

class VendorOrderProvider extends ChangeNotifier {
  bool isLoading = false;
  String? errorMessage;
  List<Order> orders = [];

  VendorOrderProvider() {
    _loadMockOrders();
  }

  Future<void> _loadMockOrders() async {
    isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 500));

    final user1 = User(
      id: 'u1',
      name: 'Ana Silva',
      email: 'ana@example.com',
     // type: 'customer',
      address: 'Av. das Acácias, 123',
      phone: '823456789',
    );
    final user2 = User(
      id: 'u2',
      name: 'João Pereira',
      email: 'joao@example.com',
     // type: 'customer',
      address: 'Rua do Sol, 45',
      phone: '854321098',
    );
    final user3 = User(
      id: 'u3',
      name: 'Mariana Costa',
      email: 'mariana@example.com',
     // type: 'customer',
      address: 'Travessa do Mercado, 78',
      phone: '845678912',
    );

    orders = [
      Order(
        id: '1001',
        date: DateTime.now().subtract(const Duration(days: 1)),
        total: 1250.00,
        status: 'pending',
        items: [
          OrderItem(name: 'p1', quantity: 2, price: 300.00),
          OrderItem(name: 'p2', quantity: 1, price: 650.00),
        ],
        customer: user1,
        notes: 'Deixar na portaria',
        paymentMethod: 'M-Pesa',
      ),
      Order(
        id: '1002',
        date: DateTime.now().subtract(const Duration(days: 2)),
        total: 890.00,
        status: 'preparing',
        items: [
          OrderItem(name: 'p3', quantity: 3, price: 200.00),
          OrderItem(name: 'p4', quantity: 1, price: 290.00),
        ],
        customer: user2,
        notes: '',
        paymentMethod: 'Dinheiro',
      ),
      Order(
        id: '1003',
        date: DateTime.now().subtract(const Duration(days: 5)),
        total: 432.50,
        status: 'delivered',
        items: [
          OrderItem(name: 'p5', quantity: 5, price: 86.50),
        ],
        customer: user3,
        notes: 'Não tocar na campainha',
        paymentMethod: 'Cartão',
      ),
    ];

    isLoading = false;
    notifyListeners();
  }

  // método que garante que getOrderById existe:
  Order? getOrderById(String orderId) {
    try {
      return orders.firstWhere((o) => o.id == orderId);
    } catch (_) {
      return null;
    }
  }

  Future<void> fetchVendorOrders(String vendorId) async {
    isLoading = true;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 300));
    isLoading = false;
    notifyListeners();
  }

  Future<void> updateVendorOrderStatus(String orderId, String newStatus) async {
    final index = orders.indexWhere((o) => o.id == orderId);
    if (index != -1) {
      orders[index].status = newStatus;
      notifyListeners();
    }
  }
}