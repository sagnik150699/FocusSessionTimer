// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:focus_session_timer/main.dart';
import 'package:provider/provider.dart';
import 'package:focus_session_timer/src/providers/theme_provider.dart';
import 'package:focus_session_timer/src/app.dart';


void main() {
  testWidgets('Golden path test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        child: const MyApp(),
      ),
    );

    // Verify that the title is displayed.
    expect(find.text('Production Grade App'), findsOneWidget);

    // Verify that the welcome message is displayed.
    expect(find.text('Welcome!'), findsOneWidget);

    // Verify that the "Get Started" button is displayed.
    expect(find.widgetWithText(ElevatedButton, 'Get Started'), findsOneWidget);
  });
}
