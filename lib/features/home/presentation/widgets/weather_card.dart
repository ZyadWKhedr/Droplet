import 'package:droplet/core/text/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WeatherCard extends StatelessWidget {
  final Gradient gradient;
  final String title;
  final String? subtitle;
  final bool isCentered;

  const WeatherCard({
    super.key,
    required this.gradient,
    required this.title,
    this.subtitle,
    this.isCentered = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 152.w,
      height: 103.h,
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: subtitle == null
                  ? AppText.body.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w200,
                    )
                  : AppText.h2.copyWith(color: Colors.white),
            ),
            if (subtitle != null)
              Text(
                subtitle!,
                style: AppText.body.copyWith(color: Colors.white),
              ),
          ],
        ),
      ),
    );
  }
}
