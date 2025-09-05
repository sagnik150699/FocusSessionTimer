// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:focus_session_timer/main.dart';
import 'package:focus_session_timer/timer_provider.dart';
import 'package:focus_session_timer/creature_provider.dart';

void main() {
  testWidgets('HomeScreen renders correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => ThemeProvider()),
          ChangeNotifierProvider(create: (context) => TimerProvider()),
          ChangeNotifierProvider(create: (context) => CreatureProvider()),
        ],
        child: const MyApp(),
      ),
    );

    // Verify that the title is displayed.
    expect(find.text('Focus Session Timer'), findsOneWidget);
  });
}
