// models/user_model.dart
class User {
  final String id;
  final String name;
  final String email;
  final String type; // 'client' ou 'supplier'

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.type,
  });
}