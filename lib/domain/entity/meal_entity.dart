/// Different types of meals that exist.
enum MealType { breakfast, lunch, dinner }

/// Different types of nutrient used in the app.
enum Nutrient { calories, carbs, protein, fat }

/// Two options that will be shown for a specific meal type.
enum MealOption { A, B }

/// The meal that is shown to the user for selecting and logging.
class MealEntity {
  final MealOption option;

  final String dish;

  final int calorie;

  final int protein;

  final int carbs;

  final int fat;

  const MealEntity({
    required this.option,
    required this.dish,
    required this.calorie,
    required this.protein,
    required this.carbs,
    required this.fat,
  });
}
