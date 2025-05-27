// controllers/auth_controller.dart
import 'package:flutter/material.dart';
import 'package:greennovo/models/user_model.dart';

class AuthController extends ChangeNotifier {
  User? _currentUser;

  User? get currentUser => _currentUser;
  bool get isLoggedIn => _currentUser != null;
  bool get isClient => _currentUser?.type == 'client';
  bool get isSupplier => _currentUser?.type == 'supplier';

  void login(User user) {
    _currentUser = user;
    notifyListeners();
  }

  void logout() {
    _currentUser = null;
    notifyListeners();
  }
}