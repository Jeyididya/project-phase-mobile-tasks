import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:task_6/features/products/data/repositories/product_repository.dart';
import 'package:task_6/features/products/data/datasourses/product_remote_data_source.dart';
import 'package:task_6/features/products/data/datasourses/product_local_data_source.dart';
import 'package:task_6/features/products/domain/entities/product.dart';
import 'package:task_6/core/network/network_info.dart';

class MockRemoteDataSource extends Mock implements ProductRemoteDataSource {}

class MockLocalDataSource extends Mock implements ProductLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late ProductRepositoryImpl repository;
  late MockRemoteDataSource mockRemote;
  late MockLocalDataSource mockLocal;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemote = MockRemoteDataSource();
    mockLocal = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();

    repository = ProductRepositoryImpl(
      remoteDataSource: mockRemote,
      localDataSource: mockLocal,
      networkInfo: mockNetworkInfo,
    );
  });

  group('getAllProducts', () {
    final product1 = Product(
      id: '1',
      name: 'Prod A',
      description: 'A product',
      price: 10.0,
      imageUrl: 'url',
    );
    final product2 = Product(
      id: '2',
      name: 'Prod B',
      description: 'B product',
      price: 20.0,
      imageUrl: 'url2',
    );

    test(
      'device online -> returns remote data and caches it locally',
      () async {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(
          () => mockRemote.getAllProducts(),
        ).thenAnswer((_) async => [product1, product2]);
        when(() => mockLocal.cacheProducts(any())).thenAnswer((_) async {});

        final result = await repository.getAllProducts();

        expect(result, isA<List<Product>>());
        expect(result.length, 2);
        verify(() => mockNetworkInfo.isConnected).called(1);
        verify(() => mockRemote.getAllProducts()).called(1);
        verify(() => mockLocal.cacheProducts([product1, product2])).called(1);
        verifyNever(() => mockLocal.getAllProducts());
      },
    );

    test('device online -> remote throws -> returns local data', () async {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(
        () => mockRemote.getAllProducts(),
      ).thenThrow(Exception('Remote failure'));
      when(
        () => mockLocal.getAllProducts(),
      ).thenAnswer((_) async => [product1]);

      final result = await repository.getAllProducts();

      expect(result, isA<List<Product>>());
      expect(result.length, 1);
      verify(() => mockRemote.getAllProducts()).called(1);
      verify(() => mockLocal.getAllProducts()).called(1);
    });

    test('device offline -> returns local cached data', () async {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      when(
        () => mockLocal.getAllProducts(),
      ).thenAnswer((_) async => [product2]);

      final result = await repository.getAllProducts();

      expect(result, isA<List<Product>>());
      expect(result.length, 1);
      verifyNever(() => mockRemote.getAllProducts());
      verify(() => mockLocal.getAllProducts()).called(1);
    });

    test('device offline -> no cached data -> throws exception', () async {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      when(() => mockLocal.getAllProducts()).thenThrow(Exception('No cache'));

      try {
        await repository.getAllProducts();
        fail('Expected an exception to be thrown');
      } catch (e) {
        expect(e, isA<Exception>());
      }

      verifyNever(() => mockRemote.getAllProducts());
      verify(() => mockLocal.getAllProducts()).called(1);
    });
  });

  group('CRUD operations', () {
    final product = Product(
      id: '1',
      name: 'Prod A',
      description: 'A product',
      price: 10.0,
      imageUrl: 'url',
    );

    test('insertProduct - online -> calls remote then local', () async {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockRemote.insertProduct(product)).thenAnswer((_) async {});
      when(() => mockLocal.insertProduct(product)).thenAnswer((_) async {});

      await repository.insertProduct(product);

      verify(() => mockRemote.insertProduct(product)).called(1);
      verify(() => mockLocal.insertProduct(product)).called(1);
    });

    test(
      'insertProduct - online and remote fails -> exception propagated, local not called',
      () async {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(
          () => mockRemote.insertProduct(product),
        ).thenThrow(Exception('Remote error'));

        try {
          await repository.insertProduct(product);
          fail('Expected an exception to be thrown');
        } catch (e) {
          expect(e, isA<Exception>());
        }

        verify(() => mockRemote.insertProduct(product)).called(1);
        verifyNever(() => mockLocal.insertProduct(product));
      },
    );

    test('insertProduct - offline -> calls local only', () async {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      when(() => mockLocal.insertProduct(product)).thenAnswer((_) async {});

      await repository.insertProduct(product);

      verifyNever(() => mockRemote.insertProduct(product));
      verify(() => mockLocal.insertProduct(product)).called(1);
    });

    test('updateProduct - online -> calls remote then local', () async {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockRemote.updateProduct(product)).thenAnswer((_) async {});
      when(() => mockLocal.updateProduct(product)).thenAnswer((_) async {});

      await repository.updateProduct(product);

      verify(() => mockRemote.updateProduct(product)).called(1);
      verify(() => mockLocal.updateProduct(product)).called(1);
    });

    test(
      'updateProduct - online and remote fails -> exception propagated, local not called',
      () async {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(
          () => mockRemote.updateProduct(product),
        ).thenThrow(Exception('Remote update error'));

        try {
          await repository.updateProduct(product);
          fail('Expected an exception to be thrown');
        } catch (e) {
          expect(e, isA<Exception>());
        }

        verify(() => mockRemote.updateProduct(product)).called(1);
        verifyNever(() => mockLocal.updateProduct(product));
      },
    );

    test('deleteProduct - online -> calls remote then local', () async {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockRemote.deleteProduct(product.id)).thenAnswer((_) async {});
      when(() => mockLocal.deleteProduct(product.id)).thenAnswer((_) async {});

      await repository.deleteProduct(product.id);

      verify(() => mockRemote.deleteProduct(product.id)).called(1);
      verify(() => mockLocal.deleteProduct(product.id)).called(1);
    });

    test(
      'deleteProduct - online and remote fails -> exception propagated, local not called',
      () async {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(
          () => mockRemote.deleteProduct(product.id),
        ).thenThrow(Exception('Remote delete error'));

        try {
          await repository.deleteProduct(product.id);
          fail('Expected an exception to be thrown');
        } catch (e) {
          expect(e, isA<Exception>());
        }

        verify(() => mockRemote.deleteProduct(product.id)).called(1);
        verifyNever(() => mockLocal.deleteProduct(product.id));
      },
    );

    test(
      'getProduct - online success -> returns remote and caches locally',
      () async {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(
          () => mockRemote.getProduct(product.id),
        ).thenAnswer((_) async => product);
        when(() => mockLocal.insertProduct(product)).thenAnswer((_) async {});

        final result = await repository.getProduct(product.id);

        expect(result, equals(product));
        verify(() => mockRemote.getProduct(product.id)).called(1);
        verify(() => mockLocal.insertProduct(product)).called(1);
      },
    );

    test('getProduct - online remote fails -> returns local', () async {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(
        () => mockRemote.getProduct(product.id),
      ).thenThrow(Exception('Remote not found'));
      when(
        () => mockLocal.getProduct(product.id),
      ).thenAnswer((_) async => product);

      final result = await repository.getProduct(product.id);

      expect(result, equals(product));
      verify(() => mockRemote.getProduct(product.id)).called(1);
      verify(() => mockLocal.getProduct(product.id)).called(1);
    });

    test('getProduct - offline -> returns local', () async {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      when(
        () => mockLocal.getProduct(product.id),
      ).thenAnswer((_) async => product);

      final result = await repository.getProduct(product.id);

      expect(result, equals(product));
      verifyNever(() => mockRemote.getProduct(product.id));
      verify(() => mockLocal.getProduct(product.id)).called(1);
    });

    test('getProduct - offline and no cache -> throws', () async {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      when(
        () => mockLocal.getProduct(product.id),
      ).thenThrow(Exception('No cache'));

      try {
        await repository.getProduct(product.id);
        fail('Expected an exception to be thrown');
      } catch (e) {
        expect(e, isA<Exception>());
      }
      verifyNever(() => mockRemote.getProduct(product.id));
      verify(() => mockLocal.getProduct(product.id)).called(1);
    });
  });
}
