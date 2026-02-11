import '../../infrastructure/utils/types.dart';
import '../entity/daily_meals_entity.dart';

abstract interface class MealRepository {
  Future<void> saveGeneratedMealPlan(JsonList? jsonList);

  Future<DailyMealsEntity?> fetchExistingMeal(
    String mealPlanId,
    DateTime currentDate,
  );
}
