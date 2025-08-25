import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../domain/entities/recommendation_entity.dart';

class RecommendationCard extends StatelessWidget {
  final Recommendation rec;
  const RecommendationCard({super.key, required this.rec});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (await canLaunchUrl(rec.articleUrl)) {
          await launchUrl(rec.articleUrl, mode: LaunchMode.externalApplication);
        }
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(rec.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              const SizedBox(height: 6),
              Text('Suggested plants: ${rec.plants.join(", ")}'),
              const SizedBox(height: 8),
              Text(
                rec.articleUrl.toString(),
                style: const TextStyle(decoration: TextDecoration.underline),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
