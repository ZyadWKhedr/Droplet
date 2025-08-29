import 'package:droplet/core/constatnts/app_gradients.dart';
import 'package:droplet/core/extensions/localization_extension%20.dart';
import 'package:droplet/features/home/presentation/providers/readings_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'weather_card.dart';

class WeatherSection extends ConsumerWidget {
  const WeatherSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final live = ref.watch(liveReadingProvider);

    return live.when(
      data: (reading) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                WeatherCard(
                  gradient: AppGradients.blue,
                  title: reading.rainDetected
                      ? context.loc.rain
                      : context.loc.norain,
                ),
                WeatherCard(
                  gradient: AppGradients.danger,
                  title: "${reading.temperature.toStringAsFixed(1)} °C",
                  subtitle: context.loc.temp,
                ),
              ],
            ),
            SizedBox(height: 24.h),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: WeatherCard(
                gradient: AppGradients.gold,
                title: "${reading.humidity.toStringAsFixed(1)} %",
                subtitle: context.loc.humidity,
              ),
            ),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, st) => Center(child: Text("Error: $err")),
    );
  }
}
