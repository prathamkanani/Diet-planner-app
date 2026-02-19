import '../../../../domain/entity/daily_meals_entity.dart';
import '../../../domain/entity/meal_option_list_entity.dart';

sealed class MealState {
  const MealState();
}

final class MealLoadingState extends MealState {
  const MealLoadingState();
}

final class MealLoadedState extends MealState {
  final MealLoggerEntity mealLoggerEntity;
  final List<MealOptionListEntity> meals;

  const MealLoadedState({required this.mealLoggerEntity, required this.meals});
}

final class MealNotFoundState extends MealState {
  const MealNotFoundState();
}

final class MealErrorState extends MealState {
  final Object? error;

  const MealErrorState(this.error);
}
