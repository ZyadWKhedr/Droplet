import 'package:droplet/core/extensions/localization_extension%20.dart';
import 'package:droplet/core/localization/l10n/app_localizations.dart';
import 'package:droplet/core/providers/app_theme_provider.dart';
import 'package:droplet/core/providers/locale_provider.dart';
import 'package:droplet/features/auth/presentation/pages/auth_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'config/screenutil_setup.dart';
import 'core/theme/app_theme.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final locale = ref.watch(localeProvider);

    return ScreenUtilSetup(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Your App',
        theme: buildLightTheme(),
        darkTheme: buildDarkTheme(),
        themeMode: themeMode,
        locale: locale,
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        home: const AuthPage(),
      ),
    );
  }
}
