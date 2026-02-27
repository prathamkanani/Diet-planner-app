import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entity/daily_meals_entity.dart';
import '../../../domain/entity/meal_entity.dart';
import '../../../domain/repository/meal_logger_repository.dart';
import '../../../domain/repository/meal_repository.dart';
import 'meal_log_state.dart';

class MealLogCubit extends Cubit<MealLogState> {
  MealLogCubit({
    required this.mealRepository,
    required this.mealLoggerRepository,
  }) : super(const MealLogInitialState());

  final MealRepository mealRepository;
  final MealLoggerRepository mealLoggerRepository;

  final DateTime selectedDate = DateTime.now();

  /// For currently selected meals.
  final Map<MealType, MealEntity> selectedMealType = {};

  /// For storing temporary logged meals.
  Map<MealType, MealEntity>? loggedMeals = {};

  /// Timer for undo functionality.
  Timer? undoTimer;

  /// The meal(s) selected in order to log them.
  void selectMeal(MealType type, MealEntity meal) {
    selectedMealType[type] = meal;
    emit(MealSelectedState(selectedMealType));
  }

  /// The unselected meals.
  void unselectMeal(MealType type) {
    selectedMealType.remove(type);
    emit(MealUnselectedState(selectedMealType));
  }

  /// This reverts the logged meals, it is valid for 10 secs timer.
  Future<void> onUndo() async {
    undoTimer?.cancel();
    undoTimer = null;
    if (loggedMeals == null) return;

    try {
      await mealLoggerRepository.deleteLoggedMeal(loggedMeals!, selectedDate);

      final DailyMealsEntity? meals = await mealRepository.fetchExistingMeal(
        selectedDate,
      );

      loggedMeals = null;

      emit(MealLogSuccessState(meals!));
    } catch (e) {
      emit(MealLogErrorState(e));
    }
  }

  /// This allows the user to log particular meal(s).
  Future<void> logMeals() async {
    if (selectedMealType.isEmpty) return;
    emit(const MealLoggingState());

    try {
      loggedMeals = Map.from(selectedMealType);
      await mealLoggerRepository.logMeal(selectedMealType, selectedDate);
      final DailyMealsEntity? dailyMealsEntity = await mealRepository
          .fetchExistingMeal(selectedDate);
      selectedMealType.clear();
      emit(MealUndoAvailableState(dailyMealsEntity!));

      // Cancel any previous timer.
      undoTimer?.cancel();
      undoTimer = Timer(const Duration(seconds: 10), () {
        if (loggedMeals != null) {
          loggedMeals = null;
          emit(MealLogSuccessState(dailyMealsEntity));
        }
      });
    } catch (e) {
      emit(MealLogErrorState(e));
    }
  }
}
