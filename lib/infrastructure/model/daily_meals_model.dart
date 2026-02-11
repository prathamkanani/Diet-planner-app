import 'dart:math';
import '../../domain/entity/daily_meals_entity.dart';
import '../../domain/entity/meal_entity.dart';
import '../../domain/entity/meal_option_list_entity.dart';
import 'meal_model.dart';
import 'meal_option_list_model.dart';

class DailyMealsModel extends DailyMealsEntity {
  DailyMealsModel({
    required super.currentDate,
    required super.mealOptionListEntity,
    required super.loggedMeal,
    required super.targetCalories,
    required super.consumedCalories
  });

  factory DailyMealsModel.fromEntity(DailyMealsEntity entity) {
    return DailyMealsModel(
      currentDate: entity.currentDate,
      mealOptionListEntity: entity.mealOptionListEntity,
      loggedMeal: entity.loggedMeal,
      targetCalories: entity.targetCalories,
      consumedCalories: entity.consumedCalories
    );
  }

  factory DailyMealsModel.fromJson(
    DateTime todayDate,
    Map<String, dynamic>? json,
    List<Map<String, dynamic>> mealLogs,
  ) {
    final Map<String, dynamic> dailyMeals = json?['meal'];
    final List<MealOptionListEntity> result = [];
    int maxCalorie = 0;
    num currentCalories = 0;
    dailyMeals.forEach((mealTypeKey, meals) {
      final mealType = MealType.values.byName(mealTypeKey);

      final List<MealEntity> mealList = [];
      int calorie = 1000000;
      for (final meal in meals as List<dynamic>) {
        final mealEntity = MealModel.fromJson(meal);
        calorie = min(calorie, mealEntity.calorie);
        mealList.add(mealEntity);
      }
      maxCalorie += calorie;

      result.add(
        MealOptionListModel(mealType: mealType, mealOptions: mealList),
      );
    });

    result.sort((a, b) {
      return a.mealType.index.compareTo(b.mealType.index);
    });

    MealType mealTypeFromString(String value) {
      return MealType.values.byName(value);
    }

    MealOption mealOptionFromString(String value) {
      return MealOption.values.byName(value);
    }

    // To convert List<Map<String, dynamic>> to Map<MealType, MealOption>
    final Map<MealType, MealOption> loggedMeals = {
      for (final meal in mealLogs)
        mealTypeFromString(meal['meal_type']): mealOptionFromString(
          meal['option'],
        ),
    };

    for(final meal in mealLogs) {
      if(meal['calories'] != null){
        currentCalories += meal['calories'];
      }
    }

    return DailyMealsModel(
      currentDate: todayDate,
      mealOptionListEntity: result,
      loggedMeal: loggedMeals,
      targetCalories: maxCalorie,
      consumedCalories: currentCalories.toInt()
    );
  }

  static List<MealType> mealOptionsToMealType(
    List<MealOptionListEntity> mealOptions,
  ) {
    return mealOptions.map((mealOption) => mealOption.mealType).toList();
  }

  static List<String> mealTypeToString(List<MealType> mealTypes) {
    return mealTypes.map((meal) => meal.name).toList();
  }

  Map<String, dynamic> toJson(
    String userId,
    String mealId,
    DateTime date,
    List<MealOptionListEntity> mealTypes,
  ) {
    return {
      'user_id': userId,
      'meal_id': mealId,
      'log_date': date,
      'logs': mealTypeToString(mealOptionsToMealType(mealTypes)),
    };
  }
}
