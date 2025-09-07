import 'package:droplet/core/constatnts/app_colors.dart';
import 'package:droplet/core/text/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool hasBorder;
  final Color color;
  final Color borderColor;
  final Color textColor;
  final double borderRadius;
  final Color textBorderColor;
  final double height;
  final double width;
  final double? fontSize; // <-- new optional parameter

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.hasBorder = false,
    this.color = AppColors.primary,
    this.borderColor = AppColors.primary,
    this.textColor = Colors.white,
    this.borderRadius = 8,
    this.height = 50,
    this.width = 327,
    this.fontSize,
    this.textBorderColor = AppColors.primary, // <-- initialize
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width.w,
      height: height.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: hasBorder ? Colors.transparent : color,
          foregroundColor: hasBorder ? borderColor : textColor,
          elevation: 0,
          side: hasBorder
              ? BorderSide(color: borderColor, width: 1.w)
              : BorderSide.none,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius.r),
          ),
        ),
        onPressed: onPressed,
        child: Center(
          child: Text(
            text,
            style: hasBorder ? AppText.borderButton : AppText.button,
          ),
        ),
      ),
    );
  }
}
