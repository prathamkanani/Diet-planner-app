import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entity/meal_entity.dart';
import '../../../domain/repository/dashboard_repository.dart';
import 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  final DashboardRepository repository;

  DashboardCubit(this.repository) : super(const DashboardLoadingState());

  Future<void> showMeal(DateTime day) async {
    try {
      final List<MealEntity> meals = await repository.mealsOfTheDay(day);
      emit(DashboardLoadedState(meals: meals));
    } catch (e) {
      emit(DashboardErrorState(e));
    }
  }
}