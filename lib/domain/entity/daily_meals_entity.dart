import 'meal_entity.dart';
import 'meal_option_list_entity.dart';

/// Shows the entire meal plan for the current day.
class DailyMealsEntity {
  /// The meal list for all the [MealType].
  final List<MealOptionListEntity> mealOptionListEntity;

  /// The entity that stores updated values after logging of meal.
  final MealLoggerEntity mealLoggerEntity;

  const DailyMealsEntity({
    required this.mealLoggerEntity,
    required this.mealOptionListEntity,
  });
}

class MealLoggerEntity {
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

  /// The date for knowing whether meal plan exists or needs to be generated.
  final DateTime mealPlanStartDate;

  /// The meal that is logged by the user.
  final Map<MealType, MealOption> loggedMeal;

  const MealLoggerEntity({
    required this.targetCalories,
    required this.consumedCalories,
    required this.targetFats,
    required this.consumedFats,
    required this.targetProtein,
    required this.consumedProtein,
    required this.targetCarbs,
    required this.consumedCarbs,
    required this.mealPlanStartDate,
    required this.currentDate,
    required this.loggedMeal,
  });
}
