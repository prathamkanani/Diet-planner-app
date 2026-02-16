import 'meal_entity.dart';

/// List of meal options for a specific [MealType].
class MealOptionListEntity {
  /// The type of meal whether its breakfast, lunch or dinner.
  final MealType mealType;

  /// The options shown for a specific [MealType].
  final List<MealEntity>? mealOptions;

  const MealOptionListEntity({
    required this.mealType,
    this.mealOptions,
  });
}
