import '../../application/service/app_data_service.dart';
import '../../domain/entity/meal_entity.dart';
import '../app_injector.dart';

class MealModel extends MealEntity {
  MealModel({
    required super.option,
    required super.dish,
    required super.calorie,
    required super.protein,
    required super.carbs,
    required super.fat,
  });

  final AppDataService appDataService = locator.get<AppDataService>();
  late final List<Map<String, dynamic>>? json = appDataService.jsonList;

  factory MealModel.fromEntity(MealEntity meal) {
    return MealModel(
      option: meal.option,
      dish: meal.dish,
      calorie: meal.calorie,
      protein: meal.protein,
      carbs: meal.carbs,
      fat: meal.fat,
    );
  }

  /// To convert AI generated meal plan from json to meal entity.
  factory MealModel.fromJson(Map<String, dynamic>? json) {
    return MealModel(
      option: MealOption.values.byName(json?['option']),
      dish: json?['name'] as String,
      calorie: json?['calories'] as int,
      protein: json?['protein_g'] as int,
      carbs: json?['carbs_g'] as int,
      fat: json?['fat_g'] as int,
    );
  }
}
