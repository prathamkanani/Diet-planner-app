enum MealType {
  breakfast('Breakfast'),
  lunch('Lunch'),
  dinner('Dinner');

  final String mealType;

  const MealType(this.mealType);
}

enum MealOption { A, B}

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
