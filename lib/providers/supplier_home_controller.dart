import 'package:flutter/material.dart';

class SupplierHomeController with ChangeNotifier {
  // Exemplo: pode futuramente armazenar entregas, encomendas, etc.
  int orderCount = 0;

  void incrementOrders() {
    orderCount++;
    notifyListeners();
  }
}