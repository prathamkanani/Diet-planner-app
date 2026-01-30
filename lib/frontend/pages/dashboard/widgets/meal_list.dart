import 'package:flutter/material.dart';
import '../../../config/app_assets.dart';
import '../../../config/app_spacing.dart';
import 'meal_tile.dart';

class MealList extends StatelessWidget {
  const MealList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        MealTile(title: 'Breakfast', image: AppAssets.breakfast),
        AppSpacing.h08,
        MealTile(title: 'Lunch', image: AppAssets.lunch),
      ],
    );
  }
}
