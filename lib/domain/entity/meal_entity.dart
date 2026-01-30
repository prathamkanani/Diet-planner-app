enum MealType { breakfast, lunch, dinner }

class MealEntity {
  final DateTime day;

  final MealType mealType;

  final String dish;

  final int calorie;

  final int protein;

  final int carbohydrate;

  final int fat;

  const MealEntity({
    required this.mealType,
    required this.dish,
    required this.day,
    required this.calorie,
    required this.protein,
    required this.carbohydrate,
    required this.fat,
  });
}
