import '../entity/meal_entity.dart';

/// Defines contract for meal logging.
abstract interface class MealLoggerRepository {
  /// It logs a meal for a particular day to keep track of
  /// whether user is correctly following the meal plan or not.
  Future<void> logMeal(Map<MealType, MealEntity> logMeals, DateTime date);
}
