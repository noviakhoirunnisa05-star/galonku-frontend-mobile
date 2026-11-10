import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:galonku_mobile/main.dart';

void main() {
  testWidgets('Onboarding tampil', (WidgetTester tester) async {
    await tester.pumpWidget(const GalonKuApp());

    expect(find.text('GalonKu'), findsOneWidget);
    expect(find.text('Mulai Sekarang'), findsOneWidget);
  });
}