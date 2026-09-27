import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:milk_seller_shop/main.dart';

void main() {
  testWidgets('shop dashboard loads with key shop information', (tester) async {
    await tester.pumpWidget(const MilkSellerApp());

    expect(find.text('Dashboard'), findsWidgets);
    expect(find.text('Recent sales'), findsOneWidget);
    expect(find.textContaining('Fresh cow milk'), findsWidgets);
    expect(find.text('New sale'), findsOneWidget);
  });

  testWidgets('recording a sale updates product stock', (tester) async {
    await tester.pumpWidget(const MilkSellerApp());

    await tester.tap(find.text('New sale'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField), '2');
    await tester.tap(find.text('Save sale'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Inventory'));
    await tester.pumpAndSettle();

    expect(find.text('46 liter'), findsOneWidget);
  });
}
