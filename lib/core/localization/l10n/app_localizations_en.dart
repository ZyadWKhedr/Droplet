// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get authSubtitle =>
      'Collect rainwater automatically, monitor weather, and grow smarter.';

  @override
  String get login => 'Login';

  @override
  String get signUp => 'Sign Up';

  @override
  String get loginTitle => 'Welcome back! Glad to see you, Again!';

  @override
  String get signUpTitle => 'Hello! Register to get started';

  @override
  String get nameInputHint => 'Username';

  @override
  String get emailInputHint => 'Enter your email';

  @override
  String get passwordInputHint => 'Enter your password';

  @override
  String get confirmPasswordInputHint => 'Confirm password';

  @override
  String get forgotPassword => 'Forgot Password?';

  @override
  String get loginOptions => 'Or Login with';

  @override
  String get registerOptions => 'Or Register with';

  @override
  String get noAccount => 'Don’t have an account?';

  @override
  String get haveAccount => 'Already have an account?';

  @override
  String get registerNow => 'Register Now';

  @override
  String get loginNow => 'Login Now';

  @override
  String get bot => 'Chatbot';

  @override
  String get botInput => 'Write a message';

  @override
  String get signOut => 'Sign Out';

  @override
  String get preferences => 'Preferences';

  @override
  String get appearance => 'Appearance';

  @override
  String get home => 'Home';

  @override
  String get aiChat => 'AI Chat';

  @override
  String get profile => 'Profile';

  @override
  String get measurements => 'Here are the last measurements';

  @override
  String get temp => 'Temperature';

  @override
  String get rain => 'Rain';

  @override
  String get humidity => 'Humidity';

  @override
  String get tank => 'Water Tank';

  @override
  String get tankClosed => 'Tank is Closed';

  @override
  String get tankOpened => 'Tank is Opened';

  @override
  String get plants => 'Plants to grow';

  @override
  String get hi => 'Hi, ';
}
