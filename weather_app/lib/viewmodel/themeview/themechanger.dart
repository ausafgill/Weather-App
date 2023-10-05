import 'package:flutter/material.dart';

class ThemeChanger with ChangeNotifier {
  var _thememode = ThemeMode.light;
  ThemeMode get currentTheme => _thememode;
  void setTheme(currentTheme) {
    _thememode = currentTheme;
    notifyListeners();
  }
}
