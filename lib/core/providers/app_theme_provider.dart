import 'package:droplet/core/services/prefs_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeModeProvider = NotifierProvider<ThemeModeController, ThemeMode>(
  ThemeModeController.new,
);

class ThemeModeController extends Notifier<ThemeMode> {
  @override
  ThemeMode build() {
    _init();
    return ThemeMode.system;
  }

  Future<void> _init() async {
    final prefs = ref.read(prefsServiceProvider);
    final value = await prefs.getThemeMode();
    if (value == 'light') state = ThemeMode.light;
    if (value == 'dark') state = ThemeMode.dark;
    if (value == 'system' || value == null) state = ThemeMode.system;
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    state = mode;
    final prefs = ref.read(prefsServiceProvider);
    await prefs.setThemeMode(switch (mode) {
      ThemeMode.light => 'light',
      ThemeMode.dark => 'dark',
      _ => 'system',
    });
  }
}

final prefsServiceProvider = Provider<PrefsService>((ref) => PrefsService());
