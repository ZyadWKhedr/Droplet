import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.pop(),
      child: Container(
        width: 41.w,
        height: 41.h,
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xffE8ECF4)),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: const Icon(Icons.arrow_back_ios_new),
      ),
    );
  }
}
