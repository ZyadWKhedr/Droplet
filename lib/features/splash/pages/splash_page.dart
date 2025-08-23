import 'package:droplet/core/constatnts/app_images.dart';
import 'package:droplet/features/splash/provider/splash_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashPage extends ConsumerWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncNav = ref.watch(splashProvider);

    return Scaffold(
      body: asyncNav.when(
        data: (nextRoute) {
          // Navigate after splash
          Future.microtask(() => context.goNamed(nextRoute));
          return Center(child: Image.asset(AppImages.logo, width: 150.w));
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
