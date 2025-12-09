import '../repositories/product_repository.dart';

class GetProduct {
  final ProductRepository repository;

  GetProduct(this.repository);

  Future<void> call(String id) {
    return repository.getProduct(id);
  }
}
