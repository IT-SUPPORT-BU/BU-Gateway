// This is a basic Flutter widget test for BU Gateway.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bu_gateway/app.dart';

void main() {
  testWidgets('BU Gateway UI smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const BuGatewayApp());

    // Verify that the title 'BU Gateway' is displayed on the splash screen.
    expect(find.text('BU Gateway'), findsOneWidget);

    // Verify that the subtitle is displayed.
    expect(find.text('Bugema University Companion Portal'), findsOneWidget);

    // Verify that the progress indicator is present.
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Let the splash screen timer run and resolve the navigation to the dashboard.
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();
  });
}


