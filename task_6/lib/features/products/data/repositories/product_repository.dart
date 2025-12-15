import '../../../../core/network/network_info.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasourses/product_local_data_source.dart';
import '../datasourses/product_remote_data_source.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;
  final ProductLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  ProductRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<void> insertProduct(Product product) async {
    if (await networkInfo.isConnected) {
      await remoteDataSource.insertProduct(product);
      await localDataSource.insertProduct(product);
    } else {
      await localDataSource.insertProduct(product);
    }
  }

  @override
  Future<void> updateProduct(Product product) async {
    if (await networkInfo.isConnected) {
      await remoteDataSource.updateProduct(product);
      await localDataSource.updateProduct(product);
    } else {
      await localDataSource.updateProduct(product);
    }
  }

  @override
  Future<void> deleteProduct(String id) async {
    if (await networkInfo.isConnected) {
      await remoteDataSource.deleteProduct(id);
      await localDataSource.deleteProduct(id);
    } else {
      await localDataSource.deleteProduct(id);
    }
  }

  @override
  Future<Product> getProduct(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProduct = await remoteDataSource.getProduct(id);

        await localDataSource.insertProduct(remoteProduct);
        return remoteProduct;
      } catch (e) {
        return await localDataSource.getProduct(id);
      }
    } else {
      return await localDataSource.getProduct(id);
    }
  }

  Future<List<Product>> getAllProducts() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProducts = await remoteDataSource.getAllProducts();

        await localDataSource.cacheProducts(remoteProducts);
        return remoteProducts;
      } catch (e) {
        return await localDataSource.getAllProducts();
      }
    } else {
      return await localDataSource.getAllProducts();
    }
  }
}
