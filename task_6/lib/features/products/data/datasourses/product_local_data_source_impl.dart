import '../../domain/entities/product.dart';
import 'product_local_data_source.dart';
// import '../models/product_model.dart';
// ignore: depend_on_referenced_packages
import 'package:shared_preferences/shared_preferences.dart';

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  final Map<String, Product> _localStorage = {};
  final SharedPreferences sharedPreferences;

  ProductLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> insertProduct(Product product) async {
    _localStorage[product.id] = product;
    await _saveToPrefs();
  }

  @override
  Future<void> updateProduct(Product product) async {
    if (!_localStorage.containsKey(product.id)) {
      throw Exception("Product not found in local storage");
    }
    _localStorage[product.id] = product;
    await _saveToPrefs();
  }

  @override
  Future<void> deleteProduct(String id) async {
    _localStorage.remove(id);
    await _saveToPrefs();
  }

  @override
  Future<Product> getProduct(String id) async {
    final product = _localStorage[id];
    if (product == null) {
      throw Exception("Product not found in local storage");
    }
    return product;
  }

  @override
  Future<List<Product>> getAllProducts() async {
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

  Future<void> _saveToPrefs() async {
    await sharedPreferences.setString(
      'products_last_updated',
      DateTime.now().toIso8601String(),
    );
  }
}
