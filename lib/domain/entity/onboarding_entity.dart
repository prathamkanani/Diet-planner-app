import '../eum/activity_level_entity.dart';
import 'health_habits_entity.dart';
import 'meal_planning.dart';
import 'profile_entity.dart';

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
