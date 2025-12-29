import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:task_6/features/products/presentation/bloc/product_bloc.dart';
import 'package:task_6/features/products/presentation/bloc/product_event.dart';
import 'package:task_6/features/products/presentation/bloc/product_state.dart';
import 'package:task_6/features/products/domain/entities/product.dart';
import 'package:task_6/features/products/domain/usecases/get_all_products.dart';
import 'package:task_6/features/products/domain/usecases/get_product.dart';
import 'package:task_6/features/products/domain/usecases/update_product.dart';
import 'package:task_6/features/products/domain/usecases/delete_product.dart';
import 'package:task_6/features/products/domain/usecases/insert_product.dart';

class MockGetAllProducts extends Mock implements GetAllProducts {}

class MockGetProduct extends Mock implements GetProduct {}

class MockUpdateProduct extends Mock implements UpdateProduct {}

class MockDeleteProduct extends Mock implements DeleteProduct {}

class MockInsertProduct extends Mock implements InsertProduct {}

void main() {
  late ProductBloc bloc;
  late MockGetAllProducts mockGetAllProducts;
  late MockGetProduct mockGetProduct;
  late MockUpdateProduct mockUpdateProduct;
  late MockDeleteProduct mockDeleteProduct;
  late MockInsertProduct mockInsertProduct;

  setUp(() {
    mockGetAllProducts = MockGetAllProducts();
    mockGetProduct = MockGetProduct();
    mockUpdateProduct = MockUpdateProduct();
    mockDeleteProduct = MockDeleteProduct();
    mockInsertProduct = MockInsertProduct();
    bloc = ProductBloc(
      getAllProducts: mockGetAllProducts,
      getProduct: mockGetProduct,
      updateProduct: mockUpdateProduct,
      deleteProduct: mockDeleteProduct,
      insertProduct: mockInsertProduct,
    );
  });

  final product = Product(
    id: '1',
    name: 'Test',
    description: 'desc',
    price: 9.99,
    imageUrl: 'url',
  );

  group('LoadAllProductsEvent', () {
    blocTest<ProductBloc, ProductState>(
      'emits [LoadingState, LoadedAllProductsState] when successful',
      build: () {
        when(() => mockGetAllProducts()).thenAnswer((_) async => [product]);
        return bloc;
      },
      act: (bloc) => bloc.add(LoadAllProductsEvent()),
      expect: () => [
        LoadingState(),
        LoadedAllProductsState([product]),
      ],
    );

    blocTest<ProductBloc, ProductState>(
      'emits [LoadingState, ErrorState] when failure',
      build: () {
        when(() => mockGetAllProducts()).thenThrow(Exception('fail'));
        return bloc;
      },
      act: (bloc) => bloc.add(LoadAllProductsEvent()),
      expect: () => [LoadingState(), ErrorState('Exception: fail')],
    );
  });

  group('GetSingleProductEvent', () {
    blocTest<ProductBloc, ProductState>(
      'emits [LoadingState, LoadedSingleProductState] when successful',
      build: () {
        when(() => mockGetProduct(product.id)).thenAnswer((_) async => product);
        return bloc;
      },
      act: (bloc) => bloc.add(GetSingleProductEvent(product.id)),
      expect: () => [LoadingState(), LoadedSingleProductState(product)],
    );

    blocTest<ProductBloc, ProductState>(
      'emits [LoadingState, ErrorState] when failure',
      build: () {
        when(() => mockGetProduct(product.id)).thenThrow(Exception('fail'));
        return bloc;
      },
      act: (bloc) => bloc.add(GetSingleProductEvent(product.id)),
      expect: () => [LoadingState(), ErrorState('Exception: fail')],
    );
  });

  group('UpdateProductEvent', () {
    blocTest<ProductBloc, ProductState>(
      'emits [LoadingState, LoadedAllProductsState] when successful',
      build: () {
        when(() => mockUpdateProduct(product)).thenAnswer((_) async => {});
        when(() => mockGetAllProducts()).thenAnswer((_) async => [product]);
        return bloc;
      },
      act: (bloc) => bloc.add(UpdateProductEvent(product)),
      expect: () => [
        LoadingState(),
        LoadedAllProductsState([product]),
      ],
    );

    blocTest<ProductBloc, ProductState>(
      'emits [LoadingState, ErrorState] when failure',
      build: () {
        when(() => mockUpdateProduct(product)).thenThrow(Exception('fail'));
        return bloc;
      },
      act: (bloc) => bloc.add(UpdateProductEvent(product)),
      expect: () => [LoadingState(), ErrorState('Exception: fail')],
    );
  });

  group('DeleteProductEvent', () {
    blocTest<ProductBloc, ProductState>(
      'emits [LoadingState, LoadedAllProductsState] when successful',
      build: () {
        when(() => mockDeleteProduct(product.id)).thenAnswer((_) async => {});
        when(() => mockGetAllProducts()).thenAnswer((_) async => [product]);
        return bloc;
      },
      act: (bloc) => bloc.add(DeleteProductEvent(product.id)),
      expect: () => [
        LoadingState(),
        LoadedAllProductsState([product]),
      ],
    );

    blocTest<ProductBloc, ProductState>(
      'emits [LoadingState, ErrorState] when failure',
      build: () {
        when(() => mockDeleteProduct(product.id)).thenThrow(Exception('fail'));
        return bloc;
      },
      act: (bloc) => bloc.add(DeleteProductEvent(product.id)),
      expect: () => [LoadingState(), ErrorState('Exception: fail')],
    );
  });

  group('CreateProductEvent', () {
    blocTest<ProductBloc, ProductState>(
      'emits [LoadingState, LoadedAllProductsState] when successful',
      build: () {
        when(() => mockInsertProduct(product)).thenAnswer((_) async => {});
        when(() => mockGetAllProducts()).thenAnswer((_) async => [product]);
        return bloc;
      },
      act: (bloc) => bloc.add(CreateProductEvent(product)),
      expect: () => [
        LoadingState(),
        LoadedAllProductsState([product]),
      ],
    );

    blocTest<ProductBloc, ProductState>(
      'emits [LoadingState, ErrorState] when failure',
      build: () {
        when(() => mockInsertProduct(product)).thenThrow(Exception('fail'));
        return bloc;
      },
      act: (bloc) => bloc.add(CreateProductEvent(product)),
      expect: () => [LoadingState(), ErrorState('Exception: fail')],
    );
  });
}
