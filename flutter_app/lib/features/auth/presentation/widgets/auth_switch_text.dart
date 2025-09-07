import 'package:droplet/core/constatnts/app_colors.dart';
import 'package:droplet/core/extensions/localization_extension%20.dart';
import 'package:droplet/core/text/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthSwitchText extends StatelessWidget {
  final bool isSignup;
  final VoidCallback onTap;

  const AuthSwitchText({
    super.key,
    required this.isSignup,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          Text(
            isSignup ? context.loc.haveAccount : context.loc.noAccount,
            style: AppText.body.copyWith(color: Colors.black),
          ),
          SizedBox(width: 5.w),
          GestureDetector(
            onTap: onTap,
            child: Text(
              isSignup ? context.loc.login : context.loc.registerNow,
              style: AppText.body.copyWith(color: AppColors.accent),
            ),
          ),
        ],
      ),
    );
  }
}
