// controllers/product_controller.dart
import 'package:flutter/material.dart';
import 'package:greennovo/models/product_model.dart';

class ProductController extends ChangeNotifier {
  String _selectedCategory = 'Frutas';
  final List<Product> _supplierProducts = []; // Lista de produtos do fornecedor

  String get selectedCategory => _selectedCategory;

  void setCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  // Métodos para o fornecedor
  void addProduct(Product product) {
    _supplierProducts.add(product);
    notifyListeners();
  }

  void updateProduct(Product oldProduct, Product newProduct) {
    final index = _supplierProducts.indexOf(oldProduct);
    if (index != -1) {
      _supplierProducts[index] = newProduct;
      notifyListeners();
    }
  }

  void removeProduct(Product product) {
    _supplierProducts.remove(product);
    notifyListeners();
  }

  List<Product> getSupplierProducts() {
    return _supplierProducts;
  }

  // Métodos para o cliente (mantidos da versão anterior)
  List<Product> getProducts() {
    final allProducts = [
      Product(name: 'Maçã', price: 75.00, category: 'Frutas'),
      Product(name: 'Goiaba', price: 75.00, category: 'Frutas'),
      // ... outros produtos padrão
    ];

    // Combine produtos padrão com os do fornecedor
    return [...allProducts, ..._supplierProducts]
        .where((p) => p.category == _selectedCategory)
        .toList();
  }

  List<String> getCategories() {
    final categories = {'Frutas', 'Grãos', 'Verduras', 'Temperos', 'Cereais'};
    // Adiciona categorias dos produtos do fornecedor
    for (var product in _supplierProducts) {
      categories.add(product.category);
    }
    return categories.toList();
  }
}