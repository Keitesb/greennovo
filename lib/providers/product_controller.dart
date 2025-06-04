// lib/providers/product_controller.dart

import 'package:flutter/material.dart';
import 'package:greennovo/models/product_model.dart';

class ProductController extends ChangeNotifier {
  final List<Product> _products = [
    Product(id: '1', name: 'Maçã', price: 75.00, category: 'Frutas'),
    Product(id: '2', name: 'Goiaba', price: 75.00, category: 'Frutas'),
    Product(id: '3', name: 'Kiwi', price: 75.00, category: 'Frutas'),
    Product(id: '4', name: 'Manga', price: 35.00, category: 'Frutas'),
    Product(id: '5', name: 'Papaia', price: 10.00, category: 'Frutas'),
    Product(id: '6', name: 'Arroz', price: 45.00, category: 'Grãos'),
    Product(id: '7', name: 'Feijão', price: 55.00, category: 'Grãos'),
    Product(id: '8', name: 'Alface', price: 15.00, category: 'Verduras'),
    Product(id: '9', name: 'Coentro', price: 5.00, category: 'Temperos'),
  ];

  String _selectedCategory = '';

  String get selectedCategory => _selectedCategory;

  void setCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  List<Product> getProducts() {
    if (_selectedCategory.isEmpty) {
      return List.unmodifiable(_products);
    }
    return List.unmodifiable(_products.where((p) =>
        p.category.toLowerCase().contains(_selectedCategory.toLowerCase())));
  }

  List<String> getCategories() {
    return _products
        .map((p) => p.category)
        .toSet()
        .toList()
      ..sort();
  }

  void addProduct(Product product) {
    _products.add(product);
    notifyListeners();
  }

  void updateProduct(Product updated) {
    final index = _products.indexWhere((p) => p.id == updated.id);
    if (index != -1) {
      _products[index] = updated;
      notifyListeners();
    }
  }

  void removeProduct(String id) {
    _products.removeWhere((p) => p.id == id);
    notifyListeners();
  }

  Product? getById(String id) {
    try {
      return _products.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }
}