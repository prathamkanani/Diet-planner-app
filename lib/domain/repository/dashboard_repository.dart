import '../entity/meal_entity.dart';

abstract interface class DashboardRepository {
  Future<List<MealEntity>> saveGeneratedMeals();

  Future<List<MealEntity>> mealsOfTheDay(DateTime day);
}