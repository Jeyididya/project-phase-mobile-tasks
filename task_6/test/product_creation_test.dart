import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:task_6/pages/home_page.dart';

void main() {
  testWidgets('Test Product Creation', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: const HomePage(
          name: "Sample product",
          category: "sample category",
          price: "125",
          desciption: "sample description",
        ),
      ),
    );

    final nameFinder = find.text("Sample product");
    final categoryFinder = find.text("sample category");
    final priceFinder = find.text("\$125");

    expect(nameFinder, findsOneWidget);
    expect(categoryFinder, findsOneWidget);
    expect(priceFinder, findsOneWidget);
  });
}
