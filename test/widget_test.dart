// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_guide/main.dart';
import 'package:travel_guide/services/destination_service.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Setup SharedPreferences
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final destinationService = DestinationService();

    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp(
      prefs: prefs,
      destinationService: destinationService,
    ));

    // Verify that the app starts with the main screen
    expect(find.byType(MainScreen), findsOneWidget);
  });
}
