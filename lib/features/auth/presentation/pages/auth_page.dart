import 'package:droplet/core/constatnts/app_images.dart';
import 'package:droplet/core/extensions/localization_extension%20.dart';
import 'package:droplet/core/text/app_text.dart';
import 'package:droplet/features/auth/presentation/widgets/custom_button.dart';
import 'package:droplet/features/auth/presentation/widgets/language_toggle_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            AppImages.backgroundAuth,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fill,
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0.sp),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 300.h),
                  Image.asset(AppImages.logo, width: 134.w, height: 134.h),
                  Text(
                    context.loc.authSubtitle,
                    style: AppText.body,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 30.h),
                  CustomButton(text: context.loc.signUp, onPressed: () {}),
                  SizedBox(height: 15.h),
                  CustomButton(
                    text: context.loc.login,
                    onPressed: () {},
                    hasBorder: true,
                  ),
                ],
              ),
            ),
          ),
          Positioned(top: 40.h, right: 10.w, child: LanguageToggleButton()),
        ],
      ),
    );
  }
}
