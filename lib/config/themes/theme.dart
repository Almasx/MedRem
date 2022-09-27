import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;
  bool get isDarkMode => themeMode == ThemeMode.dark;

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class AppTheme {
  static final lightTheme = ThemeData(
      scaffoldBackgroundColor: const Color(0xFFE3E5E8),
      fontFamily: 'SFPro-Display',
      inputDecorationTheme: const InputDecorationTheme(
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          border: InputBorder.none,
          floatingLabelBehavior: FloatingLabelBehavior.always),
      splashColor: const Color(0xFFE8EAED),
      colorScheme: const ColorScheme(
          primary: Color(0xFF4A54EB),
          secondary: Color(0xFFF2F3F5),
          surface: Colors.white,
          background: Color(0xFFE3E5E8),
          error: Color.fromARGB(255, 207, 43, 43),
          onPrimary: Colors.white,
          onSecondary: Color(0xFF737E8C),
          onSurface: Colors.black,
          onBackground: Color(0xFF2E3338),
          onError: Color(0xFFE3E5E8),
          brightness: Brightness.light));
  static final darkTheme = ThemeData(
      scaffoldBackgroundColor: const Color(0xFF020202),
      fontFamily: 'SFPro-Display',
      inputDecorationTheme: const InputDecorationTheme(
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          border: InputBorder.none,
          floatingLabelBehavior: FloatingLabelBehavior.always),
      splashColor: const Color.fromARGB(255, 37, 38, 40),
      colorScheme: const ColorScheme(
          primary: Color(0xFFFFFFFF),
          secondary: Color(0xFF1B1B1B),
          secondaryContainer: Color(0xFF373737),
          surface: Color(0xFF020202),
          background: Color(0xFF020202),
          error: Color.fromARGB(255, 200, 47, 47),
          onPrimary: Colors.white,
          onSecondary: Color(0xFFFFFFFF),
          onSurface: Color(0xFFFFFFFF),
          onBackground: Color(0xFFFFFFFF),
          onError: Color(0xFFFFFFFF),
          brightness: Brightness.dark));
}

const leagues = {
  'silver': Color(0xFFc5d9e7),
  'gold': Color(0xFFfab13b),
  'platnium': Color.fromARGB(255, 51, 53, 62)
};
