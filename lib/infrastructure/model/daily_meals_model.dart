import 'dart:math';
import '../../domain/entity/daily_meals_entity.dart';
import '../../domain/entity/meal_entity.dart';
import '../../domain/entity/meal_option_list_entity.dart';
import 'meal_model.dart';
import 'meal_option_list_model.dart';

/// Data-Transfer Object for [DailyMealsEntity].
class DailyMealsModel extends DailyMealsEntity {
  DailyMealsModel({
    required super.mealLoggerEntity,
    required super.mealOptionListEntity,
  });

  factory DailyMealsModel.fromEntity(DailyMealsEntity entity) {
    return DailyMealsModel(
      mealLoggerEntity: entity.mealLoggerEntity,
      mealOptionListEntity: entity.mealOptionListEntity,
    );
  }

  factory DailyMealsModel.fromJson(
    DateTime todayDate,
    DateTime mealPlanDate,
    Map<String, dynamic>? json,
    List<Map<String, dynamic>> mealLogs,
  ) {
    final Map<String, dynamic> dailyMeals = json?['meal'];
    final List<MealOptionListEntity> result = [];
    int maxCalorie = 0;
    int maxCarbs = 0;
    int maxFats = 0;
    int maxProteins = 0;
    num currentCalories = 0;
    num currentCarbs = 0;
    num currentFats = 0;
    num currentProteins = 0;
    dailyMeals.forEach((mealTypeKey, meals) {
      final mealType = MealType.values.byName(mealTypeKey);

      final List<MealEntity> mealList = [];
      int calorie = 1000000;
      int carb = 1000000;
      int fat = 1000000;
      int protein = 1000000;

      for (final meal in meals as List<dynamic>) {
        final mealEntity = MealModel.fromJson(meal);
        calorie = min(calorie, mealEntity.calorie);
        carb = min(carb, mealEntity.carbs);
        fat = min(fat, mealEntity.fat);
        protein = min(protein, mealEntity.protein);
        mealList.add(mealEntity);
      }
      maxCalorie += calorie;
      maxCarbs += carb;
      maxFats += fat;
      maxProteins += protein;

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

    for (final meal in mealLogs) {
      if (meal['calories'] != null) {
        currentCalories += meal['calories'];
      }
      if (meal['carbs'] != null) {
        currentCarbs += meal['carbs'];
      }
      if (meal['fats'] != null) {
        currentFats += meal['fats'];
      }
      if (meal['proteins'] != null) {
        currentProteins += meal['proteins'];
      }
    }

    return DailyMealsModel(
      mealLoggerEntity: MealLoggerEntity(
        currentDate: todayDate,
        mealPlanStartDate: mealPlanDate,
        loggedMeal: loggedMeals,
        targetCalories: maxCalorie,
        consumedCalories: currentCalories.toInt(),
        targetFats: maxFats,
        consumedFats: currentFats.toInt(),
        targetProtein: maxProteins,
        consumedProtein: currentProteins.toInt(),
        targetCarbs: maxCarbs,
        consumedCarbs: currentCarbs.toInt(),
      ),
      mealOptionListEntity: result,
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
