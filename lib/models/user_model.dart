// lib/models/user_model.dart

class User {
  final String id;
  final String name;
  final String email;
  final String type; // 'client' ou 'supplier'
  final String address; // Adicione este campo
  final String phone;   // Adicione este campo

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.type,
    required this.address, // Adicione este campo
    required this.phone,   // Adicione este campo
  });
}