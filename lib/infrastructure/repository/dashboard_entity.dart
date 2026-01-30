import '../../domain/entity/meal_entity.dart';
import '../../domain/repository/dashboard_repository.dart';

class DashboardEntityImpl implements DashboardRepository {
  @override
  Future<List<MealEntity>> mealsOfTheDay(DateTime day) {
    // TODO: implement mealsOfTheDay
    throw UnimplementedError();
  }

  @override
  Future<List<MealEntity>> saveGeneratedMeals() {
    // TODO: implement saveGeneratedMeals
    throw UnimplementedError();
  }
}