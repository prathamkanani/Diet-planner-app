import '../../../../domain/entity/meal_entity.dart';

sealed class MealLogState {
  const MealLogState();
}

final class MealLogInitialState extends MealLogState {
  final Map<MealType, MealEntity> selectedMeals;

  const MealLogInitialState(this.selectedMeals);
}

final class MealSelectedState extends MealLogState {
  final Map<MealType, MealEntity> selectedMeals;

  const MealSelectedState(this.selectedMeals);
}

final class MealLoggingState extends MealLogState {
  final bool isLogging;

  const MealLoggingState(this.isLogging);
}

final class MealLogSuccessState extends MealLogState {
  final Map<MealType, MealEntity> selectedMeals;

  const MealLogSuccessState(this.selectedMeals);
}

final class MealLogErrorState extends MealLogState {
  final Object? error;

  const MealLogErrorState(this.error);
}
