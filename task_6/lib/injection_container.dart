import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_it/get_it.dart';
import 'package:task_6/features/products/data/datasourses/product_local_data_source.dart';
import 'package:task_6/features/products/data/datasourses/product_local_data_source_impl.dart';
import 'package:task_6/features/products/data/datasourses/product_remote_data_source.dart';
import 'package:task_6/features/products/data/datasourses/product_remote_data_source_impl.dart';
import 'package:task_6/features/products/data/repositories/product_repository.dart';

import 'features/products/domain/repositories/product_repository.dart';
import 'features/products/domain/usecases/delete_product.dart';
import 'features/products/domain/usecases/get_product.dart';
import 'features/products/domain/usecases/insert_product.dart';
import 'features/products/domain/usecases/update_product.dart';
import 'core/network/network_info.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  // Core
  getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton(() => sharedPreferences);

  // Data sources
  getIt.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(),
  );
  getIt.registerLazySingleton<ProductLocalDataSource>(
    () => ProductLocalDataSourceImpl(sharedPreferences: getIt()),
  );

  // Repository
  getIt.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(
      remoteDataSource: getIt(),
      localDataSource: getIt(),
      networkInfo: getIt(),
    ),
  );

  // Use cases
  getIt.registerLazySingleton(() => InsertProduct(getIt()));
  getIt.registerLazySingleton(() => DeleteProduct(getIt()));
  getIt.registerLazySingleton(() => GetProduct(getIt()));
  getIt.registerLazySingleton(() => UpdateProduct(getIt()));
}
