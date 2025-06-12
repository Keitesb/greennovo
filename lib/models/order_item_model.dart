class OrderItem {
  final String name;
  final int quantity;
  final double? price;

  const OrderItem({
    required this.name,
    required this.quantity,
     this.price,
  });
}