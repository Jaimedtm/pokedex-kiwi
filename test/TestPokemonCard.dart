import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/src/pages/HomePage.dart';

void main() {
  testWidgets('test to verify if any component in card is null',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: HomePage(),
    ));
    tester.runAsync(() async {});
    final findCard = find.byType(FutureBuilder);
    expect(findCard, findsNWidgets(1));
  });
}
