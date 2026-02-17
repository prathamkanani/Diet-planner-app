import '../../domain/entity/daily_meals_entity.dart';
import '../../domain/repository/meal_repository.dart';
import '../source/meal_source.dart';

class MealRepositoryImpl implements MealRepository {
  final MealSource source;

  const MealRepositoryImpl(this.source);

  @override
  Future<DailyMealsEntity?> fetchExistingMeal(
    DateTime currentDate,
  ) async {
    return await source.fetchExistingMeal(currentDate);
  }
}
