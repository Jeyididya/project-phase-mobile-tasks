import '../../domain/entities/product.dart';
import 'product_remote_data_source.dart';
// import '../models/product_model.dart';

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final Map<String, Product> _mockApiStorage = {};

  @override
  Future<void> insertProduct(Product product) async {
    // Simulate API call delay
    await Future.delayed(const Duration(milliseconds: 500));
    _mockApiStorage[product.id] = product;
  }

  @override
  Future<void> updateProduct(Product product) async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (!_mockApiStorage.containsKey(product.id)) {
      throw Exception("Product not found in remote storage");
    }
    _mockApiStorage[product.id] = product;
  }

  @override
  Future<void> deleteProduct(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _mockApiStorage.remove(id);
  }

  @override
  Future<Product> getProduct(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final product = _mockApiStorage[id];
    if (product == null) {
      throw Exception("Product not found in remote storage");
    }
    return product;
  }

  @override
  Future<List<Product>> getAllProducts() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockApiStorage.values.toList();
  }
}
