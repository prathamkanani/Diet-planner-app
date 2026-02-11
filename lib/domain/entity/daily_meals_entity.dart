import 'meal_entity.dart';
import 'meal_option_list_entity.dart';

/// Shows the entire meal plan for the current day.
class DailyMealsEntity {
  final int targetCalories;
  final int consumedCalories;
  final DateTime currentDate;
  final List<MealOptionListEntity> mealOptionListEntity;
  final Map<MealType, MealOption> loggedMeal;

  const DailyMealsEntity({
    required this.targetCalories,
    required this.consumedCalories,
    required this.currentDate,
    required this.loggedMeal,
    required this.mealOptionListEntity,
  });
}
