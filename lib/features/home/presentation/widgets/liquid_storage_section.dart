import 'package:droplet/core/extensions/localization_extension%20.dart';
import 'package:droplet/core/text/app_text.dart';
import 'package:droplet/features/home/presentation/providers/usecases_providers.dart';
import 'package:droplet/features/home/presentation/widgets/liquid_storage_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LiquidStorageSection extends ConsumerWidget {
  const LiquidStorageSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final percent = ref.watch(waterPercentProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 30.h),
        Text(context.loc.tank, style: AppText.h2),
        LiquidStorageWidget(storagePercent: percent),
      ],
    );
  }
}
