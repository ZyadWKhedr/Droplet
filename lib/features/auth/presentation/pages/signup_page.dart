import 'package:droplet/core/extensions/localization_extension%20.dart';
import 'package:droplet/core/text/app_text.dart';
import 'package:droplet/features/auth/presentation/providers/auth_controller.dart';
import 'package:droplet/features/auth/presentation/providers/auth_state.dart';
import 'package:droplet/features/auth/presentation/widgets/auth_background_widget.dart';
import 'package:droplet/features/auth/presentation/widgets/auth_form.dart';
import 'package:droplet/features/auth/presentation/widgets/back_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SignupPage extends ConsumerWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return Scaffold(
      body: Stack(
        children: [
          AuthBackground(),
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 22.w),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Align(
                      alignment: AlignmentDirectional.topStart,
                      child: Padding(
                        padding: EdgeInsets.only(top: 50.h),
                        child: const BackButtonWidget(),
                      ),
                    ),
                    SizedBox(height: 28.h),
                    Text(context.loc.signUpTitle, style: AppText.h1),
                    SizedBox(height: 40.h),
                    AuthForm(
                      isLogin: false,
                      onSwitch: () => context.goNamed('login'),
                    ),
                    SizedBox(height: 100.h),
                  ],
                ),
              ),
            ),
          ),
          if (authState is AuthLoading) ...[
            Container(
              color: Colors.black.withOpacity(0.3),
              child: const Center(child: CircularProgressIndicator()),
            ),
          ],
        ],
      ),
    );
  }
}
