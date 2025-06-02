class User {
  final String id;
  final String email;
  final String? nome;
  final String? celular;
  final String? nuit;

  User({
    required this.id,
    required this.email,
    this.nome,
    this.celular,
    this.nuit,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] ?? '',
      email: map['email'] ?? '',
      nome: map['nome'],
      celular: map['celular'],
      nuit: map['nuit'],
    );
  }
}