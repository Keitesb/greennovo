
// lib/models/user_model.dart


class User {
  final String? id;
  final String email;
  final String? name;
  final String? nuit;
  final String address; // Adicione este campo
  final String phone;   // Adicione este campo

  User({
    required this.email,
    this.id,
   required this.name,
    this.nuit,
    required this.address,
    required this.phone,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] ?? '',
      email: map['email'] ?? '',
      name: map['nome'],
      nuit: map['nuit'], address: '', phone: '',
    );
  }
}