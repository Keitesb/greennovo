class OrderItem {
  final String name;
  final int quantity;
  final double price;

  const OrderItem({
    required this.name,
    required this.quantity,
    required this.price,
  });

  // Converte um Map do banco de dados para um objeto OrderItem
  factory OrderItem.fromMap(Map<String, dynamic> map) {
    return OrderItem(
      name: map['name'],
      quantity: map['quantity'],
      price: map['price'],
    );
  }

  // Converte um objeto OrderItem para um Map para salvar no banco de dados
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'quantity': quantity,
      'price': price,
    };
  }
}