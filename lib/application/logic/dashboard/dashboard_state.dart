import '../../../domain/entity/meal_entity.dart';

sealed class DashboardState {
  const DashboardState();
}

class DashboardLoadingState extends DashboardState {
  const DashboardLoadingState();
}

class DashboardLoadedState extends DashboardState {
  final List<MealEntity> meals;

  const DashboardLoadedState({required this.meals});
}

class DashboardErrorState extends DashboardState {
  final Object? error;

  const DashboardErrorState(this.error);
}
