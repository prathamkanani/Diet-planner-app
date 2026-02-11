import '../../domain/entity/meal_option_list_entity.dart';

class MealOptionListModel extends MealOptionListEntity {
  MealOptionListModel({required super.mealType, super.mealOptions});

  factory MealOptionListModel.fromEntity(MealOptionListEntity entity) {
    return MealOptionListModel(
      mealType: entity.mealType,
      mealOptions: entity.mealOptions,
    );
  }

  factory MealOptionListModel.fromJson(Map<String, dynamic>? json) {
    return MealOptionListModel(mealType: json?['mealType']);
  }
}
