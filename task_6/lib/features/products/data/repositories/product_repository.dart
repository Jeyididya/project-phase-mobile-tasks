import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final Map<String, Product> _storage = {};

  @override
  Future<void> insertProduct(Product product) async {
    _storage[product.id] = product;
  }

  @override
  Future<void> updateProduct(Product product) async {
    if (!_storage.containsKey(product.id)) {
      throw Exception("Product not found");
    }
    _storage[product.id] = product;
  }

  @override
  Future<void> deleteProduct(String id) async {
    _storage.remove(id);
  }

  @override
  Future<Product> getProduct(String id) async {
    final product = _storage[id];
    if (product == null) {
      throw Exception("Product not found");
    }
    return product;
  }
}
