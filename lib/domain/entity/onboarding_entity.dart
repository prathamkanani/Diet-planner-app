import 'activity_level_entity.dart';
import 'health_habits_entity.dart';
import 'meal_planning_entity.dart';
import 'profile_entity.dart';

class OnboardingEntity {
  final ProfileEntity profileEntity;

  final Set<HealthHabits> healthHabits;

  final MealPlanning mealPlanning;

  final ActivityLevelEntity activityLevelEntity;

  final String country;

  const OnboardingEntity({
    required this.country,
    required this.profileEntity,
    required this.healthHabits,
    required this.mealPlanning,
    required this.activityLevelEntity,
  });
}
