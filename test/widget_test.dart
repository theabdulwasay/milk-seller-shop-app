import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:milk_seller_shop/main.dart';

void main() {
  testWidgets('welcome page presents the milk shop and login options',
      (tester) async {
    await tester.pumpWidget(const MilkSellerApp());

    expect(find.text('Al Wasay'), findsOneWidget);
    expect(find.text('Fresh Milk,\nHappy Life'), findsOneWidget);
    expect(find.text('Get Started'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
  });

  testWidgets('demo login opens the shop and a sale updates stock',
      (tester) async {
    await tester.pumpWidget(const MilkSellerApp());

    await tester.ensureVisible(find.text('Login'));
    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle();
    expect(find.text('Welcome Back!'), findsOneWidget);
    expect(find.textContaining('Demo access only'), findsOneWidget);

    await tester.enterText(
      find.byKey(const ValueKey('emailField')),
      'shop@example.com',
    );
    await tester.enterText(
      find.byKey(const ValueKey('passwordField')),
      'milk1234',
    );
    await tester.ensureVisible(find.byKey(const ValueKey('loginButton')));
    await tester.tap(find.byKey(const ValueKey('loginButton')));
    await tester.pumpAndSettle();

    expect(find.text('Dashboard'), findsWidgets);
    expect(find.text('Recent sales'), findsOneWidget);

    await tester.tap(find.text('New sale'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField), '2');
    await tester.tap(find.text('Save sale'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Inventory'));
    await tester.pumpAndSettle();

    expect(find.text('46 liter'), findsOneWidget);
  });

  testWidgets('create account demo flow opens the shop', (tester) async {
    await tester.pumpWidget(const MilkSellerApp());

    await tester.ensureVisible(find.text('New to Al Wasay? Create account'));
    await tester.tap(find.text('New to Al Wasay? Create account'));
    await tester.pumpAndSettle();
    expect(find.text('Create Your Account'), findsOneWidget);

    await tester.enterText(find.byKey(const ValueKey('nameField')), 'Ayesha');
    await tester.enterText(
        find.byKey(const ValueKey('phoneField')), '03001234567');
    await tester.enterText(
      find.byKey(const ValueKey('emailField')),
      'ayesha@example.com',
    );
    await tester.enterText(
      find.byKey(const ValueKey('passwordField')),
      'milk1234',
    );
    await tester.enterText(
      find.byKey(const ValueKey('confirmPasswordField')),
      'milk1234',
    );
    await tester.ensureVisible(find.byKey(const ValueKey('signUpButton')));
    await tester.tap(find.byKey(const ValueKey('signUpButton')));
    await tester.pumpAndSettle();

    expect(find.text('Dashboard'), findsWidgets);
  });
}
