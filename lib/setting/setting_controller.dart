import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    _updateThemeMode(value);
  }

  loadSettings() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    int index = pref.getInt("theme") ?? 0;
    _themeMode = ThemeMode.values[index % 3];
    notifyListeners();
  }

  _updateThemeMode(ThemeMode value) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setInt("theme", value.index);
  }
}
