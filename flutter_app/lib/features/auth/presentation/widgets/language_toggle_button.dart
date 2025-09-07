import 'package:droplet/core/constatnts/app_colors.dart';
import 'package:droplet/core/providers/locale_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LanguageToggleButton extends ConsumerWidget {
  const LanguageToggleButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeProvider);

    return IconButton(
      icon: Icon(Icons.language, color: AppColors.primary),
      onPressed: () {
        final newLocale = locale?.languageCode == 'ar'
            ? const Locale('en')
            : const Locale('ar');
        ref.read(localeProvider.notifier).setLocale(newLocale);
      },
    );
  }
}
