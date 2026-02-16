import '../../infrastructure/utils/types.dart';
import '../entity/daily_meals_entity.dart';

/// Defines contract of meal planning operations.
abstract interface class MealRepository {
  /// Stores the generated meal plan.
  ///
  /// It is typically called once the onboarding is completed
  /// or the existing meal plan expires.
  Future<void> saveGeneratedMealPlan(JsonList? jsonList);

  /// Retrieves the meals for a specific date
  ///
  /// It is called everytime the user changes the date
  /// or when user logs a meal.
  Future<DailyMealsEntity?> fetchExistingMeal(
    DateTime currentDate,
  );
}
