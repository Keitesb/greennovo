import 'package:flutter/material.dart';
import 'package:greennovo/models/user_model.dart';

class AuthProvider extends ChangeNotifier {
  User? _currentUser;

  User? get currentUser => _currentUser;
  bool get isAuthenticated => _currentUser != null;
  bool get isClient => _currentUser?.type == 'client';
  bool get isSupplier => _currentUser?.type == 'supplier';

  // Validação de login
  Future<void> login(String email, String password) async {
    if (email == 'cliente@greengrocer.ac.mz' && password == '0000') {
      _currentUser = User(
        id: '1',
        name: 'Cliente Exemplo',
        email: email,
        type: 'client',
        address: 'Rua dos Clientes, 123',
        phone: '+258 84 000 0000',
      );
      notifyListeners();
    } else if (email == 'fornecedor@greengrocer.ac.mz' && password == '0000') {
      _currentUser = User(
        id: '2',
        name: 'Fornecedor Exemplo',
        email: email,
        type: 'supplier',
        address: 'Rua dos Fornecedores, 123',
        phone: '+258 84 111 2222',
      );
      notifyListeners();
    } else {
      throw Exception('Credenciais inválidas');
    }
  }

  void logout() {
    _currentUser = null;
    notifyListeners();
  }
}