import 'package:shared_preferences/shared_preferences.dart';

class PrefsService {
  static const _kThemeMode = 'theme_mode';
  static const _kLocale = 'locale';

  Future<void> setThemeMode(String mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kThemeMode, mode);
  }

  Future<String?> getThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_kThemeMode);
  }

  Future<void> setLocale(String code) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kLocale, code);
  }

  Future<String?> getLocale() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_kLocale);
  }
}
