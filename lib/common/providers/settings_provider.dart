import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ColorSchemeType { green, zinc, slate, red, orange }

enum BrightnessType { light, dark }

class SettingsProvider extends ChangeNotifier {
  static const String _fontSizeKey = 'font_size';
  static const String _colorSchemeKey = 'color_scheme';
  static const String _brightnessKey = 'brightness';

  double _fontSizeFactor = 1.0;
  ColorSchemeType _colorScheme = ColorSchemeType.green;
  BrightnessType _brightness = BrightnessType.dark;

  double get fontSizeFactor => _fontSizeFactor;
  ColorSchemeType get colorScheme => _colorScheme;
  BrightnessType get brightness => _brightness;

  FThemeData get currentTheme {
    switch (_colorScheme) {
      case ColorSchemeType.green:
        return _brightness == BrightnessType.dark
            ? FThemes.green.dark
            : FThemes.green.light;
      case ColorSchemeType.zinc:
        return _brightness == BrightnessType.dark
            ? FThemes.zinc.dark
            : FThemes.zinc.light;
      case ColorSchemeType.slate:
        return _brightness == BrightnessType.dark
            ? FThemes.slate.dark
            : FThemes.slate.light;
      case ColorSchemeType.red:
        return _brightness == BrightnessType.dark
            ? FThemes.red.dark
            : FThemes.red.light;
      case ColorSchemeType.orange:
        return _brightness == BrightnessType.dark
            ? FThemes.orange.dark
            : FThemes.orange.light;
    }
  }

  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _fontSizeFactor = prefs.getDouble(_fontSizeKey) ?? 1.0;
    final colorSchemeString = prefs.getString(_colorSchemeKey) ?? 'green';
    _colorScheme = ColorSchemeType.values.firstWhere(
      (e) => e.name == colorSchemeString,
      orElse: () => ColorSchemeType.green,
    );
    final brightnessString = prefs.getString(_brightnessKey) ?? 'dark';
    _brightness = BrightnessType.values.firstWhere(
      (e) => e.name == brightnessString,
      orElse: () => BrightnessType.dark,
    );
    notifyListeners();
  }

  Future<void> setFontSizeFactor(double factor) async {
    _fontSizeFactor = factor;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_fontSizeKey, factor);
    notifyListeners();
  }

  Future<void> setColorScheme(ColorSchemeType scheme) async {
    _colorScheme = scheme;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_colorSchemeKey, scheme.name);
    notifyListeners();
  }

  Future<void> setBrightness(BrightnessType brightness) async {
    _brightness = brightness;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_brightnessKey, brightness.name);
    notifyListeners();
  }
}
