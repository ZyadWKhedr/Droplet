import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final splashProvider = FutureProvider<String>((ref) async {
  final prefs = await SharedPreferences.getInstance();

  // Optional: onboarding check
  // final isFirstTime = prefs.getBool('is_first_time') ?? true;
  // if (isFirstTime) {
  //   await prefs.setBool('is_first_time', false);
  //   return '/onboarding';
  // }

  // Check login status persisted in SharedPreferences
  final isLoggedIn = prefs.getBool('is_logged_in') ?? false;

  if (isLoggedIn) {
    return 'nav'; // already logged in → go to main page
  } else {
    return 'auth'; // not logged in → go to auth page
  }
});