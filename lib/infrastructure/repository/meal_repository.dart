import '../../domain/entity/daily_meals_entity.dart';
import '../../domain/repository/meal_repository.dart';
import '../source/meal_source.dart';
import '../utils/types.dart';

class MealRepositoryImpl implements MealRepository {
  final MealSource source;

  const MealRepositoryImpl(this.source);

  @override
  Future<DailyMealsEntity?> fetchExistingMeal(
    String mealPlanId,
    DateTime currentDate,
  ) async {
    return await source.fetchExistingMeal(mealPlanId, currentDate);
  }

  @override
  Future<void> saveGeneratedMealPlan(JsonList? jsonList) async {
    await source.saveGeneratedPlan(jsonList);
  }
}
