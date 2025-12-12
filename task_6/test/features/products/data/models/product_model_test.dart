import 'package:flutter_test/flutter_test.dart';
// import '../../../../../lib/features//products/data/models/product_model.dart';
import 'package:task_6/features/products/data/models/product_model.dart';

void main() {
  final json = {
    "id": "1",
    "name": "Laptop",
    "description": "Powerful laptop",
    "price": 2500.50,
    "imageUrl": "http://example.com/laptop.png",
  };

  final model = ProductModel(
    id: "1",
    name: "Laptop",
    description: "Powerful laptop",
    price: 2500.50,
    imageUrl: "http://example.com/laptop.png",
  );

  test("should convert JSON to ProductModel", () {
    final result = ProductModel.fromJson(json);

    expect(result.id, "1");
    expect(result.name, "Laptop");
    expect(result.price, 2500.50);
  });

  test("should convert ProductModel to JSON", () {
    final result = model.toJson();

    expect(result, json);
  });
}
