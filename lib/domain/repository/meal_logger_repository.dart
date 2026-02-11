import '../entity/meal_entity.dart';

abstract interface class MealLoggerRepository {
  Future<void> logMeal(
    Map<MealType, MealEntity> logMeals,
    DateTime date,
  );
}
