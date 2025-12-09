import '../repositories/product_repository.dart';
import '../entities/product.dart';

class InsertProduct {
  final ProductRepository repository;

  InsertProduct(this.repository);

  Future<void> call(Product product) {
    return repository.insertProduct(product);
  }
}
