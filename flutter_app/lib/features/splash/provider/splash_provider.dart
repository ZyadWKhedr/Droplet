import 'package:droplet/core/providers/shared_prefs_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final splashProvider = FutureProvider<String>((ref) async {
  final prefs = ref.read(sharedPrefsProvider);
  // Optional: onboarding check
  // final isFirstTime = prefs.getBool('is_first_time') ?? true;
  // if (isFirstTime) {
  //   await prefs.setBool('is_first_time', false);
  //   return '/onboarding';
  // }

  // Check login status persisted in SharedPreferences
  final isLoggedIn = prefs.getBool('is_logged_in') ?? false;

  if (isLoggedIn) {
    return 'nav';
  } else {
    return 'auth';
  }
});
