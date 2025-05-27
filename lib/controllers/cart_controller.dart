import 'package:flutter/material.dart';
import 'package:greennovo/models/cart_item_model.dart';
import 'package:greennovo/models/order_model.dart';
import 'package:greennovo/models/product_model.dart';

class CartController extends ChangeNotifier {
  final List<CartItem> _items = [];
  final List<Order> _orders = [];

  List<CartItem> get items => _items;
  List<Order> get orders => _orders;

  /// Total de todos os itens no carrinho
  double get totalPrice {
    return _items.fold(0.0, (sum, item) => sum + (item.product.price * item.quantity));
  }

  /// Itens selecionados para checkout
  List<CartItem> get selectedItems =>
      _items.where((item) => item.isSelected).toList();

  /// Total de apenas os itens selecionados
  double get selectedItemsTotal {
    return selectedItems.fold(
      0.0,
          (sum, item) => sum + (item.product.price * item.quantity),
    );
  }

  /// Adicionar item ao carrinho
  void addToCart(Product product) {
    final index = _items.indexWhere((item) => item.product.name == product.name);
    if (index >= 0) {
      _items[index].quantity++;
    } else {
      _items.add(CartItem(product: product, quantity: 1));
    }
    notifyListeners();
  }

  /// Aumentar quantidade de um item
  void increaseQuantity(CartItem item) {
    item.quantity++;
    notifyListeners();
  }

  /// Diminuir quantidade (mínimo 1)
  void decreaseQuantity(CartItem item) {
    if (item.quantity > 1) {
      item.quantity--;
      notifyListeners();
    }
  }

  /// Remover item do carrinho
  void removeItem(CartItem item) {
    _items.remove(item);
    notifyListeners();
  }

  /// Selecionar ou desselecionar um item
  void toggleItemSelection(int index) {
    _items[index].isSelected = !_items[index].isSelected;
    notifyListeners();
  }

  /// Finalizar pedido apenas com itens selecionados
  void checkout() {
    final selected = selectedItems;

    if (selected.isEmpty) return;

    final newOrder = Order(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      date: DateTime.now().toString(),
      items: List.from(selected),
      total: selectedItemsTotal,
      status: 'Processando',
    );

    _orders.add(newOrder);

    // Remove apenas os itens selecionados do carrinho
    _items.removeWhere((item) => item.isSelected);
    notifyListeners();
  }

  /// Limpar carrinho inteiro
  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}