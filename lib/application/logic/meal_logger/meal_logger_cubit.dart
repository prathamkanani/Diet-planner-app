// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../domain/entity/meal_entity.dart';
// import '../../../domain/repository/meal_logger_repository.dart';
// import 'meal_logger_state.dart';
//
// class MealLogCubit extends Cubit<MealLogState> {
//   final MealLoggerRepository repository;
//
//   MealLogCubit({required this.repository})
//     : super(const MealLogInitialState({}));
//
//   final Map<MealType, MealEntity> _selectedMealType = {};
//   Map<MealType, MealEntity> get selectedMealType => _selectedMealType;
//
//   // void changeSelection(MealType type, MealEntity mealEntity) {
//   //   // TOdo: user pre built higher order functions.
//   //   _selectedMealType.remove(type);
//   //   emit(MealSelectedState(_selectedMealType));
//   //
//   //
//
//   //   _selectedMealType[type] = mealEntity;
//   //   emit(MealSelectedState(_selectedMealType));
//   //
//   // }
//
//   /// This selects a meal to be able to log the meal.
//   void selectedMeal(MealType type, MealEntity mealEntity) {
//     _selectedMealType[type] = mealEntity;
//     emit(MealSelectedState(_selectedMealType));
//   }
//
//   /// This unselects the meal.
//   void unselectedMeal(MealType type, MealEntity mealEntity) {
//     _selectedMealType.remove(type);
//     emit(MealLogInitialState(_selectedMealType));
//   }
//
//   /// This logs the meal and stores the log in the database.
//   Future<void> logMeal(DateTime date) async {
//     if (_selectedMealType.isEmpty) return;
//     emit(const MealLoggingState(true));
//     try {
//       await repository.logMeal(_selectedMealType, date);
//       _selectedMealType.clear();
//       emit(MealLogSuccessState(_selectedMealType));
//       await Future.delayed(const Duration(milliseconds: 300));
//       emit(const MealLoggingState(false));
//     } catch (e) {
//       emit(MealLogErrorState(e));
//     }
//   }
// }
