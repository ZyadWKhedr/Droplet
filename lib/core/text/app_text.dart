import 'package:droplet/core/constatnts/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppText {
  static const String _font = 'montserrat';

  static TextStyle get h1 => GoogleFonts.getFont(
    _font,
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: AppColors.darkPrimary,
  );

  static TextStyle get h2 => GoogleFonts.getFont(
    _font,
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: AppColors.darkPrimary,
  );

  static TextStyle get body =>
      GoogleFonts.getFont(_font, fontSize: 16, color: Colors.black87);

  static TextStyle get bodyMuted =>
      GoogleFonts.getFont(_font, fontSize: 14, color: AppColors.textMuted);

  static TextStyle get button => GoogleFonts.getFont(
    _font,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  // Optional: Add methods for custom font variations
  static TextStyle custom({
    required String fontFamily,
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? letterSpacing,
    double? height,
  }) {
    return GoogleFonts.getFont(
      fontFamily,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
      height: height,
    );
  }
}
