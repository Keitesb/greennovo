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

      final bool isSupplier = email.trim().endsWith('@greengrocer.mz');

      final String route = isSupplier
          ? 'https://backend-green-groocer.onrender.com/api/loginSuplier'
          : 'https://backend-green-groocer.onrender.com/api/login';

      final response = await http.post(
        Uri.parse(route),
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

  Future<void> signIn(String name, String email, String password,String phone, String nuit,String address) async{
    try{
      final bool isSupplier = email.trim().endsWith('@greengrocer.mz');

      final String route = isSupplier
          ? 'https://backend-green-groocer.onrender.com/api/create-supplier'
          : 'https://backend-green-groocer.onrender.com/api/register';

      final response=await http.post(
        Uri.parse(route),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'name':name,
          'email': email,
          'password': password,
          'phone':phone,
          'nuit':nuit,
          'address':address
        }),
      );

      final responseData=json.decode(response.body);

      if(response.statusCode== 200){
        _currentUser = User.fromMap(responseData['user']);
        print('Utilizador cadastrado com sucesso!');
      }else {
        throw Exception(responseData['error'] ?? 'Não foi possivel registrar utilizador');
      }

    }catch(e){
      rethrow;
    }
  }

  Future<void> logout() async {
    _currentUser = null;
    notifyListeners();
  }
}