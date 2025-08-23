import 'package:droplet/core/constatnts/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppText {
  static TextStyle get h1 => GoogleFonts.montserrat(
    fontSize: 28.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.darkPrimary,
  );

  static TextStyle get h2 => GoogleFonts.montserrat(
    fontSize: 22.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.darkPrimary,
  );

  static TextStyle get body => GoogleFonts.montserrat(
    fontSize: 16.sp,
    color: AppColors.darkPrimary,
    fontWeight: FontWeight.w500,
  );

  static TextStyle get bodyMuted =>
      GoogleFonts.montserrat(fontSize: 14.sp, color: AppColors.textMuted);

  static TextStyle get button => GoogleFonts.montserrat(
    fontSize: 20.sp,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
  static TextStyle get borderButton => GoogleFonts.montserrat(
    fontSize: 20.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.blue1,
  );

  // Optional: Add methods for custom font variations
  static TextStyle custom({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? letterSpacing,
    double? height,
  }) {
    return GoogleFonts.montserrat(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
      height: height,
    );
  }
}
