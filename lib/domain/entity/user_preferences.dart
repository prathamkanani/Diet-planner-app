/// Options for a user about meal planning.
enum MealPlanning { never, rarely, occasionally, frequently, always }

/// Options for a user about activity level.
enum ActivityLevel { low, medium, high }

/// Options for a user to choose meal preference.
enum MealPreferences { vegetarian, nonVegetarian, vegan, pescatarian }

/// Health Habits Enum that contains all the types of health habits.
enum HealthHabits {
  eatMindfully,
  eatABalancedDiet,
  eatMoreProtein,
  eatMoreFiber,
  eatMoreFruit,
  eatMoreVegetable,
  iAmNotSure,
}

/// Preferences asked to the users for generating personalized meal plan.
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
