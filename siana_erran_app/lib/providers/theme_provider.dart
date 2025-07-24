
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Theme Mode Enum
enum AppThemeMode {
  light,
  dark,
  system,
}

// Theme Provider Class
class ThemeProvider with ChangeNotifier {
  static const String _themeKey = 'app_theme_mode';
  
  AppThemeMode _themeMode = AppThemeMode.system;
  late SharedPreferences _prefs;
  bool _isInitialized = false;

  AppThemeMode get themeMode => _themeMode;
  bool get isInitialized => _isInitialized;

  // Get current theme mode based on system settings
  ThemeMode get materialThemeMode {
    switch (_themeMode) {
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.dark:
        return ThemeMode.dark;
      case AppThemeMode.system:
        return ThemeMode.system;
    }
  }

  // Check if current theme is dark
  bool isDarkMode(BuildContext context) {
    switch (_themeMode) {
      case AppThemeMode.light:
        return false;
      case AppThemeMode.dark:
        return true;
      case AppThemeMode.system:
        return MediaQuery.of(context).platformBrightness == Brightness.dark;
    }
  }

  // Initialize theme provider
  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
    final savedTheme = _prefs.getString(_themeKey);
    
    if (savedTheme != null) {
      _themeMode = AppThemeMode.values.firstWhere(
        (mode) => mode.toString() == savedTheme,
        orElse: () => AppThemeMode.system,
      );
    }
    
    _isInitialized = true;
    notifyListeners();
  }

  // Set theme mode
  Future<void> setThemeMode(AppThemeMode mode) async {
    if (_themeMode == mode) return;
    
    _themeMode = mode;
    await _prefs.setString(_themeKey, mode.toString());
    
    // Update system UI overlay style
    _updateSystemUIOverlayStyle();
    
    notifyListeners();
  }

  // Update system UI overlay style based on theme
  void _updateSystemUIOverlayStyle() {
    SystemChrome.setSystemUIOverlayStyle(
      _themeMode == AppThemeMode.dark
          ? SystemUiOverlayStyle.light
          : _themeMode == AppThemeMode.light
              ? SystemUiOverlayStyle.dark
              : SystemUiOverlayStyle.dark, // Default for system
    );
  }

  // Get theme-specific asset path
  String getThemedAsset(BuildContext context, {
    required String lightAsset,
    required String darkAsset,
  }) {
    return isDarkMode(context) ? darkAsset : lightAsset;
  }

  // Toggle between light and dark (useful for quick toggle)
  Future<void> toggleTheme() async {
    switch (_themeMode) {
      case AppThemeMode.light:
        await setThemeMode(AppThemeMode.dark);
        break;
      case AppThemeMode.dark:
        await setThemeMode(AppThemeMode.light);
        break;
      case AppThemeMode.system:
        await setThemeMode(AppThemeMode.light);
        break;
    }
  }
}