import 'package:flutter/material.dart';

/// Simple global theme service exposing a [ValueNotifier] to control the app's theme mode.
class ThemeService {
  static final ValueNotifier<ThemeMode> themeMode = ValueNotifier(
    ThemeMode.light,
  );

  static ThemeMode get current => themeMode.value;

  static bool get isLight => themeMode.value == ThemeMode.light;

  /// Returns human-readable label for current theme mode
  static String get appearanceLabel {
    switch (current) {
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.dark:
        return 'Dark';
      default:
        return 'System';
    }
  }

  /// Returns the internal theme value (for comparison purposes)
  static String get internalThemeValue {
    switch (current) {
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.dark:
        return 'Dark';
      default:
        return 'System';
    }
  }

  static void setThemeMode(ThemeMode mode) => themeMode.value = mode;

  static void setDark(bool dark) =>
      themeMode.value = dark ? ThemeMode.dark : ThemeMode.light;

  static void toggle() => themeMode.value = themeMode.value == ThemeMode.dark
      ? ThemeMode.light
      : ThemeMode.dark;
}
