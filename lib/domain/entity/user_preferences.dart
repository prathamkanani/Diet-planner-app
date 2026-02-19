import 'health_habits_entity.dart';

/// Options for a user about meal planning when he/she is being onboarded.
enum MealPlanning {
  never("Never"),
  rarely("Rarely"),
  occasionally("Occasionally"),
  frequently("Frequently"),
  always("Always");

  final String meal;

  const MealPlanning(this.meal);
}

/// Options for a user about activity level when he/she is being onboarded.
enum ActivityLevel {
  low('Not Very Active'),
  medium('Lightly Active'),
  high('Very Active');

  final String title;

  const ActivityLevel(this.title);
}

enum MealPreferences {
  vegetarian("Vegetarian"),
  nonVegetarian("Non Vegetarian"),
  vegan("Vegan"),
  pescatarian("Pescatarian");

  final String label;

  const MealPreferences(this.label);
}

class UserPreferences {
  final List<HealthHabits> healthHabits;

  final MealPlanning mealPlanning;

  final ActivityLevel activityLevel;

  final MealPreferences mealPref;

  final String country;

  const UserPreferences({
    required this.healthHabits,
    required this.mealPlanning,
    required this.activityLevel,
    required this.mealPref,
    required this.country,
  });
}
