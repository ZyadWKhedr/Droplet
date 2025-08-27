import 'package:droplet/core/providers/locale_provider.dart';
import 'package:droplet/core/text/app_text.dart';
import 'package:droplet/core/providers/shared_prefs_provider.dart';
import 'package:droplet/features/auth/presentation/providers/auth_controller.dart';
import 'package:droplet/features/auth/presentation/providers/auth_state.dart';
import 'package:droplet/features/auth/presentation/widgets/custom_button.dart';
import 'package:droplet/core/providers/app_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    final themeMode = ref.watch(themeModeProvider);
    final locale = ref.watch(localeProvider);

    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 25.sp),
      children: [
        SizedBox(height: 60.h),
        authState is AuthAuthenticated
            ? Text('Hi, ${authState.user.name ?? "User"}', style: AppText.h2)
            : const Text('Hi, Guest'),
            
        const Divider(thickness: 1),
        SizedBox(height: 25.h),

        // Appearance with toggle
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Appearance", style: TextStyle(fontSize: 18)),
            Switch(
              value: themeMode == ThemeMode.dark,
              onChanged: (val) {
                ref
                    .read(themeModeProvider.notifier)
                    .setThemeMode(val ? ThemeMode.dark : ThemeMode.light);
              },
            ),
          ],
        ),
        const Divider(thickness: 1),

        // Language with icon
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Language", style: TextStyle(fontSize: 18)),
            IconButton(
              icon: const Icon(Icons.language),
              onPressed: () {
                final current = locale?.languageCode ?? 'en';
                // Example cycle: en -> ar -> fr
                final next = switch (current) {
                  'en' => const Locale('ar'),
                  'ar' => const Locale('fr'),
                  _ => const Locale('en'),
                };
                ref.read(localeProvider.notifier).setLocale(next);
              },
            ),
          ],
        ),
        const Divider(thickness: 1),

        _buildItem("Text 2"),
        const Text("Extra text between 2nd and 3rd"),
        _buildItem("Text 3"),
        _buildItem("Text 4"),
        _buildItem("Text 5"),

        CustomButton(
          text: 'Logout',
          onPressed: () async {
            await ref.read(sharedPrefsProvider).setBool('is_logged_in', false);
            await ref.read(authStateProvider.notifier).signOut();
            context.goNamed('auth');
          },
        ),
      ],
    );
  }

  Widget _buildItem(String text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text, style: const TextStyle(fontSize: 18)),
        const Divider(thickness: 1),
      ],
    );
  }
}
