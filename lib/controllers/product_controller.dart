import 'package:flutter/material.dart';
import 'package:greennovo/models/product_model.dart';

class ProductController extends ChangeNotifier {
  String _selectedCategory = 'Frutas';

  String get selectedCategory => _selectedCategory;

  void setCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  List<Product> getProducts() {
    final allProducts = [
      Product(name: 'Maçã', price: 75.00, category: 'Frutas'),
      Product(name: 'Goiaba', price: 75.00, category: 'Frutas'),
      Product(name: 'Kiwi', price: 75.00, category: 'Frutas'),
      Product(name: 'Manga', price: 35.00, category: 'Frutas'),
      Product(name: 'Papaia', price: 10.00, category: 'Frutas'),
      Product(name: 'Arroz', price: 45.00, category: 'Grãos'),
      Product(name: 'Feijão', price: 55.00, category: 'Grãos'),
      Product(name: 'Alface', price: 15.00, category: 'Verduras'),
      Product(name: 'Coentro', price: 5.00, category: 'Temperos'),
    ];
    return allProducts.where((p) => p.category == _selectedCategory).toList();
  }

  List<String> getCategories() {
    return ['Frutas', 'Grãos', 'Verduras', 'Temperos', 'Cereais'];
  }
}