// lib/providers/auth_provider.dart
import 'package:flutter/material.dart';
import 'package:greennovo/models/user_model.dart';

class AuthProvider extends ChangeNotifier {
  User? _currentUser;

  User? get currentUser => _currentUser;
  bool get isAuthenticated => _currentUser != null;
  bool get isClient => _currentUser?.type == 'client';
  bool get isSupplier => _currentUser?.type == 'supplier';

  /// Realiza login (guarda o usuário e notifica listeners)
  void login(User user) {
    _currentUser = user;
    notifyListeners();
  }

  /// Faz logout (remove usuário e notifica listeners)
  void logout() {
    _currentUser = null;
    notifyListeners();
  }
}