import '../../../domain/entity/daily_meals_entity.dart';
import '../../../domain/entity/meal_entity.dart';

sealed class MealLogState {
  const MealLogState();
}

final class MealLogInitialState extends MealLogState {
  const MealLogInitialState();
}

final class MealLoggingState extends MealLogState {
  final bool isLogging;

  const MealLoggingState(this.isLogging);
}

final class MealSelectedState extends MealLogState {
  final Map<MealType, MealEntity> selectedMeals;

  const MealSelectedState(this.selectedMeals);
}

final class MealUnselectedState extends MealLogState {
  final Map<MealType, MealEntity> selectedMeals;

  const MealUnselectedState(this.selectedMeals);
}

final class MealLogSuccessState extends MealLogState {
  final DailyMealsEntity meals;

  const MealLogSuccessState(this.meals);
}

final class MealLogErrorState extends MealLogState {
  final Object error;

  const MealLogErrorState(this.error);
}
