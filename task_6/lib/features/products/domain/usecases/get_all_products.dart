import '../repositories/product_repository.dart';
import '../entities/product.dart';

class GetAllProducts {
  final ProductRepository repository;

  GetAllProducts(this.repository);

  Future<List<Product>> call() {
    return repository.getAllProducts();
  }
}
