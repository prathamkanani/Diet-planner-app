import '../entity/daily_meals_entity.dart';
import '../entity/user_preferences.dart';

/// Defines contract of meal planning operations.
abstract interface class MealRepository {
  /// Retrieves the meals for a specific date
  ///
  /// It is called everytime the user changes the date
  /// or when user logs a meal.
  Future<DailyMealsEntity?> fetchExistingMeal(DateTime currentDate);

  /// Retrieves user preferences for meal plan.
  Future<UserPreferences> getUserPreferences(String userId);
}
