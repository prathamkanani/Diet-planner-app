import 'package:flutter/material.dart';
import '../../../config/app_assets.dart';
import 'meal_option_card.dart';

class MealTile extends StatelessWidget {
  final String title;
  final String image;

  const MealTile({super.key, required this.title, required this.image});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = ColorScheme.of(context);

    return ClipRRect(
      borderRadius: BorderRadiusGeometry.circular(12),
      child: Material(
        child: ExpansionTile(
          backgroundColor: colorScheme.surface,
          collapsedBackgroundColor: colorScheme.surface,
          tilePadding: const EdgeInsets.symmetric(horizontal: 16),
          childrenPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          leading: Image.asset(image, width: 40, height: 40),
          title: Row(
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
            ],
          ),
          children: const [
            MealOptionCard(image: AppAssets.oats, title: 'Oats', calories: 420),
            MealOptionCard(
              image: AppAssets.fruits,
              title: 'Fruits',
              calories: 404,
            ),
          ],
        ),
      ),
    );
  }
}
