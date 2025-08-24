import 'package:droplet/core/constatnts/validators.dart';
import 'package:droplet/core/extensions/localization_extension%20.dart';
import 'package:droplet/core/widgets/top_snackbar_widget.dart';
import 'package:droplet/features/auth/presentation/providers/auth_controller.dart';
import 'package:droplet/features/auth/presentation/providers/auth_state.dart';
import 'package:droplet/features/auth/presentation/widgets/OAuth_or_row_widget.dart';
import 'package:droplet/features/auth/presentation/widgets/OAuth_row_section.dart';
import 'package:droplet/features/auth/presentation/widgets/auth_switch_text.dart';
import 'package:droplet/features/auth/presentation/widgets/custom_button.dart';
import 'package:droplet/features/auth/presentation/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthForm extends ConsumerWidget {
  final bool isLogin;
  final VoidCallback onSwitch;

  AuthForm({super.key, required this.isLogin, required this.onSwitch});

  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void submit() async {
      if (_formKey.currentState!.validate()) {
        if (isLogin) {
          await ref
              .read(authStateProvider.notifier)
              .signInEmail(
                email: _emailController.text.trim(),
                password: _passwordController.text.trim(),
              );
        } else {
          await ref
              .read(authStateProvider.notifier)
              .signUpEmail(
                username: _usernameController.text.trim(),
                email: _emailController.text.trim(),
                password: _passwordController.text.trim(),
              );
        }

        // Get the latest state after async operation
        final newState = ref.read(authStateProvider);

        if (newState is AuthUnauthenticated && newState.message != null) {
          TopSnackBar.show(
            context,
            message: newState.message!,
            backgroundColor: Colors.red,
            icon: Icons.error,
          );
        } else if (newState is AuthAuthenticated) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setBool('is_logged_in', true);

          TopSnackBar.show(
            context,
            message: isLogin
                ? 'Login successful! 🎉'
                : 'Account created successfully! 🎉',
            backgroundColor: Colors.green,
            icon: Icons.check_circle,
          );
          await prefs.setBool('is_logged_in', true);
          context.goNamed('nav');
        }
      }
    }

    return Form(
      key: _formKey,
      child: Column(
        children: [
          if (!isLogin) ...[
            CustomTextFormField(
              hintText: "UserName",
              prefixIcon: Icons.person_outline,
              controller: _usernameController,
              validator: Validators.validateUsername,
            ),
            SizedBox(height: 16.h),
          ],
          CustomTextFormField(
            hintText: "Email",
            prefixIcon: Icons.email_outlined,
            controller: _emailController,
            validator: Validators.validateEmail,
          ),
          SizedBox(height: 16.h),
          CustomTextFormField(
            hintText: "Password",
            prefixIcon: Icons.lock_outline,
            isPassword: true,
            controller: _passwordController,
            validator: Validators.validatePassword,
          ),
          SizedBox(height: 16.h),
          if (!isLogin) ...[
            CustomTextFormField(
              hintText: "Confirm Password",
              prefixIcon: Icons.lock_outline,
              isPassword: true,
              controller: _confirmPasswordController,
              validator: (val) => Validators.validateConfirmPassword(
                _passwordController.text,
                val,
              ),
            ),
          ],
          SizedBox(height: isLogin ? 62.h : 30.h),

          CustomButton(
            text: isLogin ? context.loc.login : context.loc.signUp,
            onPressed: submit,
          ),
          SizedBox(height: 50.h),
          OauthOrRowWidget(isLogin: isLogin),
          SizedBox(height: 30.h),
          OauthRowSection(),
          SizedBox(height: 40.h),
          AuthSwitchText(isSignup: !isLogin, onTap: onSwitch),
        ],
      ),
    );
  }
}
