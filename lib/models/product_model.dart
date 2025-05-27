class Product {
  final String name;
  final double price;
  final String category;
  final String unit;

  Product({
    required this.name,
    required this.price,
    required this.category,
    this.unit = 'kg',
  });
}