import '../../domain/entity/meal_entity.dart';

abstract interface class DashboardSource {
  Future<List<MealEntity>> mealsOfTheDay(DateTime day);

  Future<List<MealEntity>> saveGeneratedMeals();
}