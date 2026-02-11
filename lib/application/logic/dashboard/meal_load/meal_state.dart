import '../../../../domain/entity/daily_meals_entity.dart';

sealed class MealState {
  const MealState();
}

final class MealLoadingState extends MealState {
  const MealLoadingState();
}

final class MealLoadedState extends MealState {
  final DailyMealsEntity dailyMealList;

  const MealLoadedState({required this.dailyMealList});
}

final class MealNotFoundState extends MealState {
  const MealNotFoundState();
}

final class MealErrorState extends MealState {
  final Object? error;

  const MealErrorState(this.error);
}
