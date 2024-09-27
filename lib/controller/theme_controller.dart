import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  AdaptiveThemeMode _themeMode = AdaptiveThemeMode.dark;

  ThemeProvider() {
    _loadThemePreference();
  }

  AdaptiveThemeMode get themeMode => _themeMode;

  Future<void> _loadThemePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isDarkMode = prefs.getBool('is_dark_mode') ?? true;
    _themeMode = isDarkMode ? AdaptiveThemeMode.dark : AdaptiveThemeMode.light;
    notifyListeners();
  }

  Future<void> setThemeMode(
      BuildContext context, AdaptiveThemeMode mode) async {
    _themeMode = mode;
    AdaptiveTheme.of(context).setThemeMode(mode);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_dark_mode', mode == AdaptiveThemeMode.dark);
    notifyListeners();
  }

  Future<void> toggleTheme(BuildContext context) async {
    if (_themeMode == AdaptiveThemeMode.light) {
      await setThemeMode(context, AdaptiveThemeMode.dark);
    } else {
      await setThemeMode(context, AdaptiveThemeMode.light);
    }
  }
}
