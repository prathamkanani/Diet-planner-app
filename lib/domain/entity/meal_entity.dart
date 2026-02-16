/// Different types of meals that exist.
enum MealType {
  breakfast('Breakfast'),
  lunch('Lunch'),
  dinner('Dinner');

  final String mealType;

  const MealType(this.mealType);
}

/// Different types of nutrient used in the app.
enum Nutrient {
  calories('Calories'),
  carbs('Carbs'),
  protein('Protein'),
  fat('Fat');

  final String nutrientType;

  const Nutrient(this.nutrientType);
}

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
