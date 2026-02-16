import 'package:bloc/bloc.dart';
import '../../../../domain/entity/meal_entity.dart';
import '../../../../domain/repository/meal_logger_repository.dart';
import 'meal_log_state.dart';

class MealLogCubit extends Cubit<MealLogState> {
  final MealLoggerRepository repository;

  MealLogCubit({required this.repository})
    : super(const MealLogInitialState({}));

  final Map<MealType, MealEntity> _selectedMealType = {};

  void changeSelection(MealType type, MealEntity mealEntity) {
    // TOdo: user pre built higher order functions.
    if (_selectedMealType.remove(type) != null) {
      emit(MealSelectedState(_selectedMealType));
      return;
    }

    _selectedMealType[type] = mealEntity;
    emit(MealSelectedState(_selectedMealType));
  }

  /// This selects a meal to be able to log the meal.
  void selectedMeal(MealType type, MealEntity mealEntity) {
    // final updated = Map<MealType, MealEntity>.from(_selectedMealType);

    _selectedMealType[type] = mealEntity;

    // _selectedMealType = updated;
    emit(MealSelectedState(_selectedMealType));
  }

  /// This unselects the meal.
  void unselectedMeal(MealType type, MealEntity mealEntity) {
    // if (_selectedMealType.remove(type) != null) return;

    // final updated = Map<MealType, MealEntity>.from(_selectedMealType);

    _selectedMealType.remove(type);

    // _selectedMealType = updated;
    emit(MealLogInitialState(_selectedMealType));
  }

  /// This logs the meal and stores the log in the database.
  Future<void> logMeal(DateTime date) async {
    if (_selectedMealType.isEmpty) return;
    emit(const MealLoggingState(true));
    try {
      //ToDo: remove reference breaking when not needed.
      // final mealsToLog = Map<MealType, MealEntity>.from(_selectedMealType);
      await repository.logMeal(_selectedMealType, date);
      //ToDo: use clear method to remove the data.
      _selectedMealType.clear();
      //ToDo: pass proper value.
      emit(MealLogSuccessState(_selectedMealType));
      await Future.delayed(const Duration(milliseconds: 300));
      emit(const MealLoggingState(false));
    } catch (e) {
      emit(MealLogErrorState(e));
    }
  }
}
