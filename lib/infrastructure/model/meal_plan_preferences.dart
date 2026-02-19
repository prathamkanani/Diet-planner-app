import '../../domain/entity/user_preferences.dart';

class MealPlanPreferences {
  final String country;
  final ActivityLevel activityLevel;
  final int dailyCalories;

  MealPlanPreferences({
    required this.country,
    required this.activityLevel,
    required this.dailyCalories,
  });

  static String activityInstructions(ActivityLevel level) {
    switch (level) {
      case ActivityLevel.low:
        return '''
        - Lower total carbohydrates
        - Moderate protein
        - Smaller portion sizes
        - Avoid heavy dinners
      ''';
      case ActivityLevel.medium:
        return '''
        - Balanced carbohydrates and protein
        - Moderate portion sizes
        - Even calorie distribution across meals
      ''';
      case ActivityLevel.high:
        return '''
          - Higher carbohydrates
          - Higher protein
          - Include calorie-dense but healthy meals
          - Larger post-activity meals
        ''';
    }
  }

  static String countryInstructions(String country) {
    return '''
      - Use ingredients commonly available in $country
      - Prefer local and traditional foods of $country
      - Avoid ingredients uncommon or expensive in $country
      - Meal names should sound natural in $country
    ''';
  }
}
