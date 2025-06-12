import '../models/category_model.dart';

class Product {
  final String? id;
  final String name;
  final double grossPrice;
  final double? iva;
  final double? price;
  final CategoryModel category;
  final String? expire_date;
  final String? created_at;
  final String? updated_at;

  Product({
    this.id,
    required this.name,
    required this.grossPrice,
    this.iva,
    this.price,
    required this.category,
    this.expire_date,
    this.created_at,
    this.updated_at,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id']?.toString(),
      name: json['name'] ?? '',
      grossPrice: (json['grossPrice'] as num?)?.toDouble() ?? 0.0,
      iva: (json['iva'] as num?)?.toDouble() ?? 0.0,
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      category: CategoryModel.fromJson(json['category']),
      expire_date: json['expire_date']?.toString(),
      created_at: json['created_at']?.toString(),
      updated_at: json['updated_at']?.toString(),
    );
  }


  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'grossPrice': grossPrice,
      if (iva != null) 'iva': iva,
      if (price != null) 'price': price,
      'category': category.toJson(),
      if (expire_date != null) 'expire_date': expire_date,
      if (created_at != null) 'created_at': created_at,
      if (updated_at != null) 'updated_at': updated_at,
    };
  }
}