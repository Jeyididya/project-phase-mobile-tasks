import 'dart:convert';

import '../../domain/entities/product.dart';
import 'product_local_data_source.dart';
// ignore: depend_on_referenced_packages
import 'package:shared_preferences/shared_preferences.dart';

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  final Map<String, Product> _localStorage = {};
  final SharedPreferences sharedPreferences;

  static const _kProductsKey = 'products';

  ProductLocalDataSourceImpl({required this.sharedPreferences});

  Future<void> _loadFromPrefsIfNeeded() async {
    if (_localStorage.isNotEmpty) return;

    final jsonString = sharedPreferences.getString(_kProductsKey);
    if (jsonString == null) return;

    try {
      final decoded = json.decode(jsonString) as List<dynamic>;
      for (final item in decoded) {
        final map = Map<String, dynamic>.from(item as Map);
        final product = Product(
          id: map['id'] as String,
          name: map['name'] as String,
          description: map['description'] as String,
          price: (map['price'] as num).toDouble(),
          imageUrl: map['imageUrl'] as String,
        );
        _localStorage[product.id] = product;
      }
    } catch (_) {
      // ignore malformed cache
    }
  }

  Future<void> _saveToPrefs() async {
    final list = _localStorage.values.map((p) {
      return {
        'id': p.id,
        'name': p.name,
        'description': p.description,
        'price': p.price,
        'imageUrl': p.imageUrl,
      };
    }).toList();

    await sharedPreferences.setString(_kProductsKey, json.encode(list));
  }

  @override
  Future<void> insertProduct(Product product) async {
    await _loadFromPrefsIfNeeded();
    _localStorage[product.id] = product;
    await _saveToPrefs();
  }

  @override
  Future<void> updateProduct(Product product) async {
    await _loadFromPrefsIfNeeded();
    if (!_localStorage.containsKey(product.id)) {
      throw Exception("Product not found in local storage");
    }
    _localStorage[product.id] = product;
    await _saveToPrefs();
  }

  @override
  Future<void> deleteProduct(String id) async {
    await _loadFromPrefsIfNeeded();
    _localStorage.remove(id);
    await _saveToPrefs();
  }

  @override
  Future<Product> getProduct(String id) async {
    await _loadFromPrefsIfNeeded();
    final product = _localStorage[id];
    if (product == null) {
      throw Exception("Product not found in local storage");
    }
    return product;
  }

  @override
  Future<List<Product>> getAllProducts() async {
    await _loadFromPrefsIfNeeded();
    return _localStorage.values.toList();
  }

  @override
  Future<void> cacheProducts(List<Product> products) async {
    _localStorage.clear();
    for (var product in products) {
      _localStorage[product.id] = product;
    }
    await _saveToPrefs();
  }
}
