import '../../domain/entity/onboarding_entity.dart';

class OnboardingModel extends OnboardingEntity {
  OnboardingModel({
    required super.country,
    required super.profileEntity,
    required super.healthHabits,
    required super.mealPlanning,
    required super.activityLevelEntity,
  });

  factory OnboardingModel.fromEntity(OnboardingEntity entity) {
    return OnboardingModel(
      country: entity.country,
      profileEntity: entity.profileEntity,
      healthHabits: entity.healthHabits,
      mealPlanning: entity.mealPlanning,
      activityLevelEntity: entity.activityLevelEntity,
    );
  }

  factory OnboardingModel.fromJson(Map<String, dynamic> json) {
    return OnboardingModel(
      country: json['country'] as String,
      profileEntity: json['profile_id'],
      healthHabits: json['health_habits'],
      mealPlanning: json['meal_planning'],
      activityLevelEntity: json['activity_level'],
    );
  }
}
