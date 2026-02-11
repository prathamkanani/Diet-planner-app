import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/entity/daily_meals_entity.dart';
import '../../../../domain/repository/meal_repository.dart';
import '../../../../infrastructure/app_injector.dart';
import '../../../../infrastructure/utils/types.dart';
import '../../../service/app_data_service.dart';
import 'meal_state.dart';

class MealLoadingCubit extends Cubit<MealState> {
  final MealRepository repository;

  MealLoadingCubit(this.repository)
    : _selectedDate = DateTime.now(),
      super(const MealLoadingState());

  /// Getting user id to know first time meal generation or not.
  final AppDataService appDataService = locator.get();

  /// Storing selected date.
  DateTime _selectedDate;

  DateTime get selectedDate => _selectedDate;

  Future<void> fetchExistingMealPlan(String mealPlanId, DateTime day) async {
    try {
      final DailyMealsEntity? ml = await repository.fetchExistingMeal(
        mealPlanId,
        day,
      );
      if (ml != null) {
        emit(MealLoadedState(dailyMealList: ml));
        return;
      }
      emit(const MealNotFoundState());
    } catch (e) {
      emit(MealErrorState(e));
    }
  }

  Future<void> saveGeneratedMealPlan(JsonList? jsonList) async {
    try {
      await repository.saveGeneratedMealPlan(jsonList);
      emit(const MealLoadingState());
    } catch (e) {
      emit(MealErrorState(e));
    }
  }

  Future<void> changedDate(DateTime date) async {
    _selectedDate = date;
    emit(const MealLoadingState());

    try {
      final DailyMealsEntity? mealList = await repository.fetchExistingMeal(
        appDataService.mealPlanId!,
        date,
      );
      if (mealList == null) {
        emit(const MealNotFoundState());
      } else {
        emit(MealLoadedState(dailyMealList: mealList));
      }
    } catch (e) {
      emit(MealErrorState(e));
    }
  }

  void previousDay() {
    changedDate(_selectedDate.subtract(const Duration(days: 1)));
  }

  void nextDay() {
    if (isToday(_selectedDate)) return;
    changedDate(_selectedDate.add(const Duration(days: 1)));
  }

  bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }
}
