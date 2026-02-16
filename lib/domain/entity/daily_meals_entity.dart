import 'meal_entity.dart';
import 'meal_option_list_entity.dart';

/// Shows the entire meal plan for the current day.
class DailyMealsEntity {
  /// Target calories to be achieved by the user.
  final int targetCalories;

  /// Calories consumed by the user.
  final int consumedCalories;

  /// Target fats to be achieved by the user.
  final int targetFats;

  /// Fats consumed by the user.
  final int consumedFats;

  /// Target protein to be achieved by the user.
  final int targetProtein;

  /// Protein consumed by the user.
  final int consumedProtein;

  /// Target carbohydrates to be achieved by the user.
  final int targetCarbs;

  /// Carbohydrates consumed by the user.
  final int consumedCarbs;

  /// The current/today date for showing the meals for the day.
  final DateTime currentDate;

  /// The meal list for all the [MealType].
  final List<MealOptionListEntity> mealOptionListEntity;

  /// The meal that is logged by the user.
  final Map<MealType, MealOption> loggedMeal;

  const DailyMealsEntity({
    required this.targetCalories,
    required this.consumedCalories,
    required this.targetFats,
    required this.consumedFats,
    required this.targetProtein,
    required this.consumedProtein,
    required this.targetCarbs,
    required this.consumedCarbs,
    required this.currentDate,
    required this.loggedMeal,
    required this.mealOptionListEntity,
  });
}
