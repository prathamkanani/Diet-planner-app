import 'package:bloc/bloc.dart';
import '../../../../domain/entity/meal_entity.dart';
import '../../../../domain/repository/meal_logger_repository.dart';
import 'meal_log_state.dart';

class MealLogCubit extends Cubit<MealLogState> {
  final MealLoggerRepository repository;

  MealLogCubit({required this.repository})
    : super(const MealLogInitialState({}));

  Map<MealType, MealEntity> _selectedMealType = {};

  void selectedMeal(MealType type, MealEntity mealEntity) {
    final updated = Map<MealType, MealEntity>.from(_selectedMealType);

    updated[type] = mealEntity;

    _selectedMealType = updated;
    emit(MealSelectedState(_selectedMealType));
  }

  void unselectedMeal(MealType type, MealEntity mealEntity) {
    if(!_selectedMealType.containsKey(type)) return;

    final updated = Map<MealType, MealEntity>.from(_selectedMealType);

    updated.remove(type);

    _selectedMealType = updated;
    emit(MealLogInitialState(_selectedMealType));
  }

  Future<void> logMeal(DateTime date) async {
    if (_selectedMealType.isEmpty) return;
    emit(const MealLoggingState(true));
    try {
      final mealsToLog = Map<MealType, MealEntity>.from(_selectedMealType);
      int caloriesLogged = mealsToLog.values.fold<int>(
        0,
        (int sum, MealEntity meal) => sum += meal.calorie,
      );
      await repository.logMeal(mealsToLog, date);
      _selectedMealType = {};
      emit(MealLogSuccessState({}, caloriesLogged));
      emit(const MealLoggingState(false));
    } catch (e) {
      emit(MealLogErrorState(e));
    }
  }
}
