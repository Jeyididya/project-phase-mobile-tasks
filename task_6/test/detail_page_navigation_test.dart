import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:task_6/pages/home_page.dart';
import 'package:task_6/pages/product_detail.dart';
import 'package:task_6/pages/search_page.dart';

void main() {
  testWidgets("Detail page Navigation", (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        routes: {
          "/detail": (context) => const ProductDetail(),
          '/search': (context) => const SearchPage(),
        },
        home: const HomePage(),
      ),
    );

    await tester.tap(
      find.byType(GestureDetector).at(1),
    ); // select the second element
    await tester.pumpAndSettle();

    expect(find.text("Mens's show"), findsOneWidget);
    expect(find.text("Derby Leather"), findsOneWidget);
    expect(find.text("\$120"), findsOneWidget);
    expect(find.text("⭐(4.0)"), findsOneWidget);
  });
}
