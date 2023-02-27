import 'package:flutter/material.dart';

class SettingsController with ChangeNotifier {
  SettingsController._();
  static SettingsController instance = SettingsController._();
  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;
  setThemeMode(ThemeMode value) {
    if (value == _themeMode) {
      return;
    }
    _themeMode = value;
    notifyListeners();
  }
}
