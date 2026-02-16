import 'package:flutter/material.dart';
import '../../../../domain/entity/meal_entity.dart';
import 'nutrients_chip.dart';

class NutrientsRow extends StatelessWidget {
  final MealEntity mealEntity;

  const NutrientsRow({super.key, required this.mealEntity});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        NutrientChip(
          nutrientType: .calories,
          nutrientValue: mealEntity.calorie,
        ),
        NutrientChip(nutrientType: .carbs, nutrientValue: mealEntity.carbs),
        NutrientChip(
          nutrientType: .protein,
          nutrientValue: mealEntity.protein,
        ),
        NutrientChip(nutrientType: .fat, nutrientValue: mealEntity.fat),
      ],
    );
  }
}
