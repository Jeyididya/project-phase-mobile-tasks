import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
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

import 'features/products/presentation/bloc/product_bloc.dart';
import 'features/products/domain/usecases/get_all_products.dart';
import 'core/network/network_info.dart';

final getIt = GetIt.instance;
Future<void> init() async {
  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton(() => sharedPreferences);
  getIt.registerLazySingleton(() => InternetConnectionChecker());

  // Core
  getIt.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(connectionChecker: getIt()),
  );

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
  // Bloc
  getIt.registerFactory(
    () => ProductBloc(
      getAllProducts: getIt<GetAllProducts>(),
      getProduct: getIt<GetProduct>(),
      updateProduct: getIt<UpdateProduct>(),
      deleteProduct: getIt<DeleteProduct>(),
      insertProduct: getIt<InsertProduct>(),
    ),
  );
}
