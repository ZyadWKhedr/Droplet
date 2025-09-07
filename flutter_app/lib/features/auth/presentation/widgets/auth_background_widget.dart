import 'package:droplet/core/constatnts/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthBackground extends StatelessWidget {
  const AuthBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
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
      ],
    );
  }
}
