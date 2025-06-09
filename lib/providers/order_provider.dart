import 'package:flutter/material.dart';
import '../models/order_model.dart';
import '../models/order_item_model.dart';
import '../models/user_model.dart';
import '../providers/auth_provider.dart';

/// Provider responsável pelo gerenciamento de pedidos do usuário.
/// Pronto para integração futura com API real.
class OrderProvider extends ChangeNotifier {
  final List<Order> _orders = [];
  bool _isLoading = false;
  String? _error;

  // Getters
  bool get isLoading => _isLoading;
  String? get error => _error;
  List<Order> get orders => List.unmodifiable(_orders);

  /// Retorna um pedido pelo ID, ou null se não encontrado.
  Order? getOrderById(String id) {
    for (final order in _orders) {
      if (order.id == id) return order;
    }
    return null;
  }

  /// Atualiza o status de um pedido e notifica listeners.
  void updateOrderStatus(String id, String newStatus) {
    final order = getOrderById(id);
    if (order != null) {
      order.status = newStatus;
      notifyListeners();
    }
  }

  /// Limpa a lista de pedidos e estado de erro.
  void clear() {
    _orders.clear();
    _error = null;
    _isLoading = false;
    notifyListeners();
  }

  /// Busca pedidos simulados (mock) para o usuário autenticado.
  /// Troque o conteúdo deste método por chamada de API real futuramente.
  Future<void> fetchOrders(AuthProvider auth) async {
    if (!auth.isLoggedIn) return;
    if (_isLoading) return;
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 1)); // simula delay de API
      // Dados mockados - troque por chamada real futuramente
      _orders
        ..clear()
        ..addAll([
          Order(
            id: 'AC5869KFNS',
            date: DateTime(2023, 9, 27),
            total: 260.00,
            status: 'pending',
            items: [
              const OrderItem(name: 'Maçã', quantity: 3, price: 75.00),
              const OrderItem(name: 'Manga', quantity: 2, price: 20.00),
            ],
            customer: User(
              id: '1',
              name: 'Keite Banze',
              email: 'keite@email.com',
           //   type: 'client',
              address: 'Bairro indígena',
              phone: '+258 84 577 2140',
            ),
            notes: 'Não misturar com lacticinios, coisas assim assim, nem sei o que escrever',
            paymentMethod: 'm-pesa',
          ),
          Order(
            id: 'SD893SKBRSF6',
            date: DateTime(2023, 10, 10),
            total: 580.00,
            status: 'preparing',
            items: [
              const OrderItem(name: 'Uva', quantity: 4, price: 150.00),
            ],
            customer: User(
              id: '2',
              name: 'Carlos Mendes',
              email: 'carlos@email.com',
           //   type: 'client',
              address: 'Avenida Central',
              phone: '+258 82 123 4567',
            ),
            notes: '',
            paymentMethod: 'm-pesa',
          ),
          Order(
            id: 'YUD893SKJDML',
            date: DateTime(2023, 11, 11),
            total: 1000.00,
            status: 'shipped',
            items: [
              const OrderItem(name: 'Pessego', quantity: 5, price: 200.00),
            ],
            customer: User(
              id: '3',
              name: 'Ana Lopes',
              email: 'ana@email.com',
            //  type: 'client',
              address: 'Rua das Flores',
              phone: '+258 87 999 8888',
            ),
            notes: 'Entregar após as 17h',
            paymentMethod: 'cartão',
          ),
        ]);
    } catch (e) {
      _error = 'Erro ao buscar pedidos: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Exemplo de buscar detalhes de um pedido pelo ID (mock, pronto para API).
  Future<Order?> fetchOrderDetail(String orderId) async {
    // Simule um delay e procure na lista de pedidos mockados
    await Future.delayed(const Duration(milliseconds: 600));
    return getOrderById(orderId);
    // No futuro, chame a API para buscar detalhes do pedido por ID.
  }
}