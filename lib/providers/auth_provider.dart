// lib/providers/auth_provider.dart
import 'package:flutter/material.dart';
import 'package:greennovo/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthProvider extends ChangeNotifier {
  User? _currentUser;

  User? get currentUser => _currentUser;
  bool get isLoggedIn => _currentUser != null;

  Future<void> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:3702/api/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email, 'password': password}),
      );

      final responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        _currentUser = User.fromMap(responseData['user']);
        notifyListeners();
      } else {
        throw Exception(responseData['error'] ?? 'Erro no login');
      }
    } catch (e) {
      rethrow;
    }
  }

  /// Faz logout (remove usuário e notifica listeners)
  void logout() {
    _currentUser = null;
    notifyListeners();
  }
}