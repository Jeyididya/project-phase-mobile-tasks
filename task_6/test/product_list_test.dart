import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:task_6/pages/home_page.dart';

void main() {
  testWidgets("Test products list", (tester) async {
    await tester.pumpWidget(MaterialApp(home: const HomePage()));

    final nameFinder = find.text("Derby Leather Shoes");
    final priceFinder = find.text("\$120");
    final iconFinder = find.byIcon(Icons.star);
    final categoryFinder = find.text("Men\'s shoe");
    final rateFinder = find.text("(4.0)");

    expect(nameFinder, findsNWidgets(3));
    expect(priceFinder, findsNWidgets(3));
    expect(iconFinder, findsNWidgets(3));
    expect(categoryFinder, findsNWidgets(3));
    expect(rateFinder, findsNWidgets(3));
  });
}
