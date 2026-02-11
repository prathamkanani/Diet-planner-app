import 'meal_entity.dart';

class MealOptionListEntity {
  final MealType mealType;
  final List<MealEntity>? mealOptions;

  const MealOptionListEntity({
    required this.mealType,
    this.mealOptions,
  });
}
