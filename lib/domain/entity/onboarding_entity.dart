import 'health_habits_entity.dart';
import 'profile_entity.dart';

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

/// The entity that is created when a user is onboarded.
class OnboardingEntity {
  final ProfileEntity profileEntity;

  final List<HealthHabits> healthHabits;

  final MealPlanning mealPlanning;

  final ActivityLevel activityLevel;

  final String country;

  const OnboardingEntity({
    required this.country,
    required this.profileEntity,
    required this.healthHabits,
    required this.mealPlanning,
    required this.activityLevel,
  });
}
