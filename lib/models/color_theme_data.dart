import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ColorThemeData with ChangeNotifier {
  final ThemeData _greenTheme = ThemeData(
    primaryColor: Colors.green,
    primarySwatch: Colors.green,
    scaffoldBackgroundColor: Colors.green,
    appBarTheme: AppBarTheme(color: Colors.green),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textTheme: TextTheme(
      subtitle1: TextStyle(color: Colors.white),
      headline3: TextStyle(color: Colors.white),
    ),
  );

  final ThemeData _pinkTheme = ThemeData(
    primaryColor: Colors.pink,
    primarySwatch: Colors.pink,
    scaffoldBackgroundColor: Colors.pink,
    appBarTheme: AppBarTheme(color: Colors.pink),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textTheme: TextTheme(
      subtitle1: TextStyle(color: Colors.white),
      headline3: TextStyle(color: Colors.white),
    ),
  );

  final ThemeData _redTheme = ThemeData(
    primaryColor: Colors.red,
    primarySwatch: Colors.red,
    scaffoldBackgroundColor: Colors.red,
    appBarTheme: AppBarTheme(color: Colors.red),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textTheme: TextTheme(
      subtitle1: TextStyle(color: Colors.white),
      headline3: TextStyle(color: Colors.white),
    ),
  );

  final ThemeData _purpleTheme = ThemeData(
    primaryColor: Colors.purple,
    primarySwatch: Colors.purple,
    scaffoldBackgroundColor: Colors.purple,
    appBarTheme: AppBarTheme(color: Colors.purple),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textTheme: TextTheme(
      subtitle1: TextStyle(color: Colors.white),
      headline3: TextStyle(color: Colors.white),
    ),
  );

  final List<ThemeData> _colorThemes = [];
  ThemeData _selectedThemeData;

  ColorThemeData()
      : _selectedThemeData = ThemeData.light() {
    _colorThemes.addAll([_greenTheme, _redTheme, _pinkTheme, _purpleTheme]);
    loadSelectedTheme();
  }

  Future<void> switchTheme(int index) async {
    _selectedThemeData = _colorThemes[index];
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('selectedThemeIndex', index);
  }

  Future<void> loadSelectedTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int index = prefs.getInt('selectedThemeIndex') ?? 0;
    _selectedThemeData = _colorThemes[index];
    notifyListeners();
  }

  ThemeData get selectedThemeData => _selectedThemeData;
  List<ThemeData> get colorThemes => _colorThemes;
}
