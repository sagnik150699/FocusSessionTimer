
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'creature_provider.dart';
import 'home_screen.dart';
import 'timer_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => TimerProvider()),
        ChangeNotifierProvider(create: (context) => CreatureProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const MaterialColor primarySeedColor = Colors.deepPurple;

    final TextTheme appTextTheme = TextTheme(
      displayLarge: GoogleFonts.montserrat(fontSize: 72, fontWeight: FontWeight.bold, letterSpacing: -2),
      titleLarge: GoogleFonts.montserrat(fontSize: 24, fontWeight: FontWeight.w600),
      bodyMedium: GoogleFonts.montserrat(fontSize: 16),
    );

    ElevatedButtonThemeData getElevatedButtonTheme(Brightness brightness) {
      final color = brightness == Brightness.light ? primarySeedColor : primarySeedColor.shade200;
      return ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          textStyle: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.w600),
          elevation: 8,
          shadowColor: color.withAlpha(100),
        ),
      );
    }

    CardThemeData getCardTheme(Brightness brightness) {
      final shadowColor = brightness == Brightness.light ? primarySeedColor : Colors.black;
      return CardThemeData(
        elevation: 12,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        shadowColor: shadowColor.withAlpha(brightness == Brightness.light ? 60 : 150),
      );
    }

    final ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primarySeedColor,
        brightness: Brightness.light,
      ),
      textTheme: appTextTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleTextStyle: GoogleFonts.montserrat(fontSize: 24, fontWeight: FontWeight.bold, color: primarySeedColor),
        iconTheme: const IconThemeData(color: primarySeedColor),
      ),
      elevatedButtonTheme: getElevatedButtonTheme(Brightness.light),
      cardTheme: getCardTheme(Brightness.light),
    );

    final ThemeData darkTheme = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primarySeedColor,
        brightness: Brightness.dark,
        surface: Colors.grey[850],
      ),
      textTheme: appTextTheme.apply(
        bodyColor: Colors.white70,
        displayColor: Colors.white,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleTextStyle: GoogleFonts.montserrat(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      elevatedButtonTheme: getElevatedButtonTheme(Brightness.dark),
      cardTheme: getCardTheme(Brightness.dark),
    );

    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Focus Session Timer',
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: themeProvider.themeMode,
          home: const HomeScreen(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
