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

  /// To fetch a meal for a certain day from the existing meal plan
  Future<void> fetchExistingMealPlan(DateTime day) async {
    try {
      final DailyMealsEntity? ml = await repository.fetchExistingMeal(day);
      if (ml != null) {
        emit(MealLoadedState(dailyMealList: ml));
        return;
      }
      emit(const MealNotFoundState());
    } catch (e) {
      emit(MealErrorState(e));
    }
  }

  /// To save the meal plan generated for the first time or when the old plan is expired.
  Future<void> saveGeneratedMealPlan(JsonList? jsonList) async {
    try {
      await repository.saveGeneratedMealPlan(jsonList);
      emit(const MealLoadingState());
    } catch (e) {
      emit(MealErrorState(e));
    }
  }

  /// When the date is changed to look at previous meals or logs.
  Future<void> changedDate(DateTime date) async {
    _selectedDate = date;
    emit(const MealLoadingState());

    try {
      final DailyMealsEntity? mealList = await repository.fetchExistingMeal(
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

  /// Helper function for going to the previous day.
  void previousDay() {
    changedDate(_selectedDate.subtract(const Duration(days: 1)));
  }

  /// Helper function for going to the next day.
  void nextDay() {
    if (isToday(_selectedDate)) return;
    changedDate(_selectedDate.add(const Duration(days: 1)));
  }

  /// Helper function to check whether selected date is today or not.
  /// This does not allow showing of future meals.
  bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }
}
