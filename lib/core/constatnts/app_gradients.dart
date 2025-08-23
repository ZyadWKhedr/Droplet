import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppGradients {
  static const danger = LinearGradient(
    colors: [AppColors.danger, AppColors.dangerDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const blue = LinearGradient(
    colors: [AppColors.blue1, AppColors.blue2],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const gold = LinearGradient(
    colors: [AppColors.gold1, AppColors.gold2],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
