import 'package:flutter/material.dart';
import '../../../../domain/entity/daily_meals_entity.dart';
import '../../../../domain/entity/meal_option_list_entity.dart';
import 'meal_tile.dart';

class DailyMealList extends StatelessWidget {
  final DailyMealsEntity dailyMealsEntity;

  const DailyMealList({super.key, required this.dailyMealsEntity});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: dailyMealsEntity.mealOptionListEntity.length,
      itemBuilder: (BuildContext context, int index) {
        final MealOptionListEntity meal =
            dailyMealsEntity.mealOptionListEntity[index];

        return MealTile(
          mealOptionListEntity: meal,
          loggedMeals: dailyMealsEntity.loggedMeal,
          currentDate: dailyMealsEntity.currentDate,
        );
      },
    );
  }
}
