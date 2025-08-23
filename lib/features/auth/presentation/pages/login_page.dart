import 'package:droplet/core/constatnts/app_images.dart';
import 'package:droplet/core/extensions/localization_extension%20.dart';
import 'package:droplet/core/text/app_text.dart';
import 'package:droplet/features/auth/presentation/widgets/auth_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            bottom: 350.h,
            left: 75.w,
            child: Image.asset(
              AppImages.rightAuthShape,
              width: 400.w,
              height: 377.12.h,
            ),
          ),

          Positioned(
            top: 670.h,
            left: 0,
            right: 0,
            child: Image.asset(
              AppImages.bottomAuthShape,
              fit: BoxFit.fill,
              width: 1.sw,
              height: 150.h,
            ),
          ),

          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 22.w),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Align(
                      alignment: AlignmentGeometry.topLeft,
                      child: GestureDetector(
                        onTap: () => context.pop(),
                        child: Padding(
                          padding: EdgeInsets.only(top: 50.h),
                          child: Container(
                            width: 41.w,
                            height: 41.h,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color(0xffE8ECF4),
                              ),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: const Icon(Icons.arrow_back_ios_new),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 28.h),
                    Text(context.loc.loginTitle, style: AppText.h1),
                    SizedBox(height: 40.h),
                    AuthForm(
                      isLogin: true,
                      onSwitch: () => context.goNamed('signup'),
                    ),
                    SizedBox(
                      height: 100.h,
                    ), // padding so bottom shape doesn't overlap
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
