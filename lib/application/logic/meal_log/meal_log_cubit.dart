import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entity/daily_meals_entity.dart';
import '../../../domain/entity/meal_entity.dart';
import '../../../domain/repository/meal_logger_repository.dart';
import '../../../domain/repository/meal_repository.dart';
import '../meal_load/meal_cubit.dart';
import 'meal_log_state.dart';

class MealLogCubit extends Cubit<MealLogState> {
  MealLogCubit({
    required this.mealRepository,
    required this.mealLoggerRepository,
    required this.mealLoadingCubit
  }) : super(const MealLogInitialState());

  final MealRepository mealRepository;
  final MealLoggerRepository mealLoggerRepository;
  final MealLoadingCubit mealLoadingCubit;

  final DateTime _selectedDate = DateTime.now();

  DateTime get selectedDate => _selectedDate;

  final Map<MealType, MealEntity> _selectedMealType = {};

  Map<MealType, MealEntity> get selectedMealType => _selectedMealType;

  // Future<void> fetchMeals(DateTime date) async {
  //   _selectedDate = date;
  //   emit(const MealLogInitialState());
  //
  //   try {
  //     final meals = await mealRepository.fetchExistingMeal(date);
  //     if (meals == null) {
  //       emit(const DashboardMealNotFoundState());
  //     } else {
  //       emit(DashboardLoadedState(meals));
  //     }
  //   } catch (e) {
  //     emit(MealLogErrorState(e));
  //   }
  // }

  // Future<void> changedDate(DateTime date) async {
  //   _selectedDate = date;
  //
  //   try {
  //     final DailyMealsEntity? mealList = await mealRepository.fetchExistingMeal(
  //       date,
  //     );
  //     if (mealList == null) {
  //       emit(const DashboardMealNotFound());
  //     } else {
  //       emit(DashboardMealLoaded(mealList));
  //     }
  //   } catch (e) {
  //     emit(DashboardMealError(e));
  //   }
  // }
  //
  // void previousDay() {
  //   fetchMeals(_selectedDate.subtract(const Duration(days: 1)));
  // }
  //
  // void nextDay() {
  //   if (_isToday(_selectedDate)) return;
  //   fetchMeals(_selectedDate.add(const Duration(days: 1)));
  // }
  //
  // bool _isToday(DateTime date) {
  //   final now = DateTime.now();
  //   return date.year == now.year &&
  //       date.month == now.month &&
  //       date.day == now.day;
  // }
  //
  void selectMeal(MealType type, MealEntity meal) {
    _selectedMealType[type] = meal;
    emit(MealSelectedState(_selectedMealType));
  }

  void unselectMeal(MealType type) {
    _selectedMealType.remove(type);
    emit(MealUnselectedState(_selectedMealType));
  }

  Future<void> logMeals() async {
    if (_selectedMealType.isEmpty) return;
    emit(const MealLoggingState(true));

    try {
      await mealLoggerRepository.logMeal(_selectedMealType, _selectedDate);
      final DailyMealsEntity? dailyMealsEntity = await mealRepository
          .fetchExistingMeal(_selectedDate);
      mealLoadingCubit.loadAfterMealLogging(dailyMealsEntity!);
      _selectedMealType.clear();
      emit(MealLogSuccessState(dailyMealsEntity));
      emit(const MealLoggingState(false));
    } catch (e) {
      emit(MealLogErrorState(e));
    }
  }
}
