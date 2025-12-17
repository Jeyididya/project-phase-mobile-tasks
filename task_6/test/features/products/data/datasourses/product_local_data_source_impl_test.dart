import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:task_6/features/products/data/datasourses/product_local_data_source_impl.dart';
import 'package:task_6/features/products/domain/entities/product.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late ProductLocalDataSourceImpl dataSource;
  late MockSharedPreferences mockPrefs;

  setUp(() {
    mockPrefs = MockSharedPreferences();
    dataSource = ProductLocalDataSourceImpl(sharedPreferences: mockPrefs);
  });

  final product = Product(
    id: '1',
    name: 'Test',
    description: 'desc',
    price: 9.99,
    imageUrl: 'url',
  );

  group('getAllProducts', () {
    test('returns products from prefs when present', () async {
      final list = [
        {
          'id': product.id,
          'name': product.name,
          'description': product.description,
          'price': product.price,
          'imageUrl': product.imageUrl,
        },
      ];

      when(() => mockPrefs.getString('products')).thenReturn(json.encode(list));

      final result = await dataSource.getAllProducts();

      expect(result, isA<List<Product>>());
      expect(result.length, 1);
      expect(result.first.id, product.id);
      verify(() => mockPrefs.getString('products')).called(1);
    });

    test('returns empty list when prefs has no data', () async {
      when(() => mockPrefs.getString('products')).thenReturn(null);

      final result = await dataSource.getAllProducts();

      expect(result, isA<List<Product>>());
      expect(result.length, 0);
      verify(() => mockPrefs.getString('products')).called(1);
    });
  });

  group('insertProduct', () {
    test('inserts and saves to prefs', () async {
      when(() => mockPrefs.getString('products')).thenReturn(null);
      when(
        () => mockPrefs.setString(any(), any()),
      ).thenAnswer((_) async => true);

      await dataSource.insertProduct(product);

      verify(
        () => mockPrefs.setString('products', any(that: contains(product.id))),
      ).called(1);
    });
  });

  group('updateProduct', () {
    test('updates existing product', () async {
      final list = [
        {
          'id': product.id,
          'name': product.name,
          'description': product.description,
          'price': product.price,
          'imageUrl': product.imageUrl,
        },
      ];
      when(() => mockPrefs.getString('products')).thenReturn(json.encode(list));
      when(
        () => mockPrefs.setString(any(), any()),
      ).thenAnswer((_) async => true);

      final updated = Product(
        id: product.id,
        name: 'Updated',
        description: 'desc',
        price: 19.99,
        imageUrl: 'url',
      );

      await dataSource.updateProduct(updated);

      verify(
        () => mockPrefs.setString('products', any(that: contains('Updated'))),
      ).called(1);
    });

    test('throws when product not found', () async {
      when(() => mockPrefs.getString('products')).thenReturn(null);

      expect(
        () => dataSource.updateProduct(product),
        throwsA(isA<Exception>()),
      );
    });
  });

  group('deleteProduct', () {
    test('deletes product and updates prefs', () async {
      final list = [
        {
          'id': product.id,
          'name': product.name,
          'description': product.description,
          'price': product.price,
          'imageUrl': product.imageUrl,
        },
      ];
      when(() => mockPrefs.getString('products')).thenReturn(json.encode(list));
      when(
        () => mockPrefs.setString(any(), any()),
      ).thenAnswer((_) async => true);

      await dataSource.deleteProduct(product.id);

      verify(
        () => mockPrefs.setString(
          'products',
          any(that: isNot(contains(product.id))),
        ),
      ).called(1);
    });
  });

  group('getProduct', () {
    test('returns product when present', () async {
      final list = [
        {
          'id': product.id,
          'name': product.name,
          'description': product.description,
          'price': product.price,
          'imageUrl': product.imageUrl,
        },
      ];
      when(() => mockPrefs.getString('products')).thenReturn(json.encode(list));

      final result = await dataSource.getProduct(product.id);

      expect(result.id, product.id);
    });

    test('throws when not found', () async {
      when(() => mockPrefs.getString('products')).thenReturn(null);

      expect(
        () => dataSource.getProduct(product.id),
        throwsA(isA<Exception>()),
      );
    });
  });

  group('cacheProducts', () {
    test('caches list and saves to prefs', () async {
      when(
        () => mockPrefs.setString(any(), any()),
      ).thenAnswer((_) async => true);

      await dataSource.cacheProducts([product]);

      verify(
        () => mockPrefs.setString('products', any(that: contains(product.id))),
      ).called(1);
    });
  });
}
