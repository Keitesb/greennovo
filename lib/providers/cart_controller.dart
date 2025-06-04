import 'package:flutter/material.dart';
import '../models/cart_item_model.dart';
import '../models/order_model.dart';
import '../models/order_item_model.dart';
import '../models/product_model.dart';
import '../models/user_model.dart';

class CartController extends ChangeNotifier {
  final List<CartItem> _items = [];
  final List<Order> _orders = [];

  List<CartItem> get items => _items;
  List<Order> get orders => _orders;

  double get totalPrice =>
      _items.fold(0.0, (sum, item) => sum + (item.product.price * item.quantity));

  List<CartItem> get selectedItems =>
      _items.where((item) => item.isSelected).toList();

  double get selectedItemsTotal =>
      selectedItems.fold(0.0, (sum, item) => sum + (item.product.price * item.quantity));

  void addToCart(Product product) {
    final index = _items.indexWhere((item) => item.product.id == product.id);
    if (index >= 0) {
      _items[index].quantity++;
    } else {
      _items.add(CartItem(product: product, quantity: 1));
    }
    notifyListeners();
  }

  void increaseQuantity(CartItem item) {
    item.quantity++;
    notifyListeners();
  }

  void decreaseQuantity(CartItem item) {
    if (item.quantity > 1) {
      item.quantity--;
      notifyListeners();
    }
  }

  void removeItem(CartItem item) {
    _items.remove(item);
    notifyListeners();
  }

  void toggleItemSelection(int index) {
    _items[index].isSelected = !_items[index].isSelected;
    notifyListeners();
  }

  /// Finalizar pedido apenas com itens selecionados
  /// Agora exige também os campos obrigatórios do Order model
  void checkout({
    required User customer,
    String notes = '',
    String paymentMethod = 'm-pesa',
  }) {
    final selected = selectedItems;
    if (selected.isEmpty) return;

    final List<OrderItem> orderItems = selected.map((cartItem) {
      return OrderItem(
        name: cartItem.product.name,
        quantity: cartItem.quantity,
        price: cartItem.product.price,
      );
    }).toList();

    final newOrder = Order(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      date: DateTime.now(),
      items: orderItems,
      total: selectedItemsTotal,
      status: 'pending', // Use o status correto do seu fluxo
      customer: customer,
      notes: notes,
      paymentMethod: paymentMethod,
    );

    _orders.add(newOrder);
    _items.removeWhere((item) => item.isSelected);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}