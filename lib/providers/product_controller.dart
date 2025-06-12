import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:greennovo/models/category_model.dart';
import 'package:greennovo/models/product_model.dart';

import '../providers/product_controller.dart';

class ProductController extends ChangeNotifier {
  List<Product> _products = [];
  List<Product> _allProducts = [];
  CategoryModel? _selectedCategory;
  bool _isLoading = false;
  String _error = '';
  String _searchProduct = '';

  CategoryModel? get selectedCategory => _selectedCategory;
  List<Product> get products => _products;
  bool get isLoading => _isLoading;
  String get error => _error;
  String get searchTerm => _searchProduct;

  Future<void> fetchProducts() async {
    _isLoading = true;
    print("Pduct fetchind");
    notifyListeners();

    try {
      final response = await http.get(
        Uri.parse('https://backend-green-groocer.onrender.com/api/list-product'),
        headers: {'Content-Type': 'application/json'},
      );
      print("Pduct response status: ${response.statusCode}");
      print("Pduct response body: ${response.body}");

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        _products = data.map((json) => Product.fromJson(json)).toList();
        _allProducts = List.from(_products);
        _error = '';
      } else {
        _error = 'Failed to load products: ${response.statusCode}';
        _products = [];
        _allProducts = [];
      }
    } catch (e) {
      _error = 'Connection error: $e';
      print('fetchProducts : product error $e');
      _products = [];
      _allProducts = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void setCategory(CategoryModel? category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void setSearchproduct(String prod) {
    _searchProduct = prod;
    notifyListeners();
  }

  List<Product> getFilteredAndSearchedProducts(String prod) {
    List<Product> filteredList = _allProducts;

    if (_selectedCategory != null) {
      filteredList = filteredList
          .where((p) => p.category.name == _selectedCategory!.name)
          .toList();
    }

    if (prod.isNotEmpty) {
      final String lowerCaseSearchTerm = prod.toLowerCase();
      filteredList = filteredList.where((product) {
        final String lowerCaseProductName = product.name.toLowerCase();
        return lowerCaseProductName.contains(lowerCaseSearchTerm);
      }).toList();
    }
    return List.unmodifiable(filteredList);
  }

  List<Product> getFilteredProducts() {
    if (_selectedCategory == null) {
      return List.unmodifiable(_products);
    }
    return List.unmodifiable(
        _products.where((p) => p.category.name == _selectedCategory!.name));
  }

  List<CategoryModel> getCategories() {
    final categories = _products.map((p) => p.category).toSet().toList();
    categories.sort((a, b) => a.name.compareTo(b.name));
    return categories;
  }

  Future<void> addProduct(Product product) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse('https://backend-green-groocer.onrender.com/api/products'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(product.toJson()),
      );

      if (response.statusCode == 201) {
        await fetchProducts();
      } else {
        _error = 'Failed to add product: ${response.statusCode}';
      }
    } catch (e) {
      _error = 'Connection error: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateProduct(Product updated) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.put(
        Uri.parse('https://backend-green-groocer.onrender.com/api/products/${updated.id}'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(updated.toJson()),
      );

      if (response.statusCode == 200) {
        await fetchProducts();
      } else {
        _error = 'Failed to update product: ${response.statusCode}';
      }
    } catch (e) {
      _error = 'Connection error: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> removeProduct(String id) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.delete(
        Uri.parse('https://backend-green-groocer.onrender.com/api/products/$id'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        await fetchProducts();
      } else {
        _error = 'Failed to delete product: ${response.statusCode}';
      }
    } catch (e) {
      _error = 'Connection error: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Product? getProductById(String id) {
    try {
      return _products.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }
}

