import 'package:droplet/core/constatnts/app_gradients.dart';
import 'package:droplet/core/extensions/localization_extension%20.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'weather_card.dart';

class WeatherSection extends StatelessWidget {
  const WeatherSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const WeatherCard(gradient: AppGradients.blue, title: 'Rainning'),
            WeatherCard(
              gradient: AppGradients.danger,
              title: '32 C',
              subtitle: context.loc.temp,
            ),
          ],
        ),
        SizedBox(height: 24.h),
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: WeatherCard(
            gradient: AppGradients.gold,
            title: '32 C',
            subtitle: context.loc.humidity,
          ),
        ),
      ],
    );
  }
}
