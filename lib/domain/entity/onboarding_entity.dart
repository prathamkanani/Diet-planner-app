import 'activity_level_entity.dart';
import 'dialog_entity.dart';
import 'health_habits_entity.dart';
import 'meal_planning_entity.dart';
import 'profile_entity.dart';

class OnboardingEntity {
  final ProfileEntity profileEntity;

  final HealthHabitsEntity healthHabitsEntity;

  final MealPlanningEntity mealPlanningEntity;

  final ActivityLevelEntity activityLevelEntity;

  final DialogEntity dialogEntity;

  const OnboardingEntity(
    this.profileEntity,
    this.healthHabitsEntity,
    this.mealPlanningEntity,
    this.activityLevelEntity,
    this.dialogEntity,
  );
}
