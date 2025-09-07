import 'package:droplet/features/ai/domain/entities/recommendation_entity.dart';
import 'package:droplet/features/ai/presentation/providers/ai_providers.dart';
import 'package:droplet/features/home/presentation/providers/readings_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlantRecommendationsWidget extends ConsumerWidget {
  const PlantRecommendationsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final liveReading = ref.watch(liveReadingProvider);

    return liveReading.when(
      data: (reading) {
        final recsAsync = ref.watch(plantRecommendationsProvider(reading));

        return recsAsync.when(
          data: (recs) {
            if (recs.isEmpty) {
              return const Text(
                'No recommendations available for this weather.',
              );
            }
            return SizedBox(
              height: 150.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                itemCount: recs.length,
                itemBuilder: (context, index) {
                  return _RecommendationCard(rec: recs[index]);
                },
                separatorBuilder: (_, __) => SizedBox(width: 15.w),
              ),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (_, __) => const Text('Error loading recommendations'),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, __) => const Text('Error loading live reading'),
    );
  }
}

class _RecommendationCard extends StatelessWidget {
  final Recommendation rec;
  const _RecommendationCard({required this.rec});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: Container(
        width: 152.w,
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: Color(0xffFBFEFB),
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              rec.title,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              rec.plants.join(', '),
              style: TextStyle(fontSize: 14.sp, color: Colors.grey[700]),
            ),
          ],
        ),
      ),
    );
  }
}
