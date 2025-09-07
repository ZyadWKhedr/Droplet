import 'package:droplet/core/providers/app_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final localeProvider = StateNotifierProvider<LocaleController, Locale?>((ref) {
  return LocaleController(ref);
});

class LocaleController extends StateNotifier<Locale?> {
  final Ref _ref;
  LocaleController(this._ref) : super(null) {
    _init();
  }

  Future<void> _init() async {
    final prefs = _ref.read(prefsServiceProvider);
    final code = await prefs.getLocale();
    if (code != null) state = Locale(code);
  }

  Future<void> setLocale(Locale? locale) async {
    state = locale;
    final prefs = _ref.read(prefsServiceProvider);
    await prefs.setLocale(locale?.languageCode ?? 'en');
  }
}
