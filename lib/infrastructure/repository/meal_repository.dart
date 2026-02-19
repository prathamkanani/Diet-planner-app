import '../../domain/entity/daily_meals_entity.dart';
import '../../domain/entity/user_preferences.dart';
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

  @override
  Future<UserPreferences> getUserPreferences(String userId) async {
    return await source.getUserPreferences(userId);
  }
}
