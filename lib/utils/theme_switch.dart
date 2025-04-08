import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeSwitch extends ChangeNotifier {
  final SharedPreferences sharedPreferences;
  ThemeSwitch({required this.sharedPreferences}) {
    _initTheme();
  }

  bool isDarkTheme = true;
  void setTheme(bool isDark) {
    isDarkTheme = isDark;
    sharedPreferences.setBool("isDark", isDark);
    notifyListeners();
  }

  void _initTheme() {
    isDarkTheme = sharedPreferences.getBool("isDark") ?? true;
    print("Darkk-----------------------> $isDarkTheme");
  }
}
