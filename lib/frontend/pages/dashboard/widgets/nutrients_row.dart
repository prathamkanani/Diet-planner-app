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
        NutrientChip(nutrientType: .calories, nutrientVal: mealEntity.calorie),
        NutrientChip(nutrientType: .carbs, nutrientVal: mealEntity.carbs),
        NutrientChip(nutrientType: .protein, nutrientVal: mealEntity.protein),
        NutrientChip(nutrientType: .fat, nutrientVal: mealEntity.fat),
      ],
    );
  }
}
