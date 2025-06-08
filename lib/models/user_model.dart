class User {
  final String id;
  final String name;
  final String email;
  final String type;
  final String address;
  final String phone;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.type,
    required this.address,
    required this.phone,
  });

  // Converte um mapa em um objeto User
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      type: map['type'],
      address: map['address'],
      phone: map['phone'],
    );
  }

  // Converte um objeto User em um mapa para o SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'type': type,
      'address': address,
      'phone': phone,
    };
  }
}