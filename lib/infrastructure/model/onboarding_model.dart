import '../../domain/entity/onboarding_entity.dart';
import '../../domain/entity/profile_entity.dart';
import '../extension/meal_pref_extension.dart';
import '../utils/helpers.dart';
import 'user_pref_model.dart';

class OnboardingModel extends OnboardingEntity {
  OnboardingModel({
    required super.profileEntity,
    required super.userPreferences,
  });

  factory OnboardingModel.fromEntity(OnboardingEntity entity) {
    return OnboardingModel(
      profileEntity: entity.profileEntity,
      userPreferences: entity.userPreferences,
    );
  }

  factory OnboardingModel.fromJson(
    Map<String, dynamic> json,
    ProfileEntity? profile,
  ) {
    return OnboardingModel(
      profileEntity: profile!,
      userPreferences: UserPrefModel.fromJson(json),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': profileEntity.userId,
      'health_habit': habitsToDb(userPreferences.healthHabits),
      'meal_planning': userPreferences.mealPlanning.name,
      'activity': userPreferences.activityLevel.name,
      'meal_pref': userPreferences.mealPref.dbValue,
      'country': userPreferences.country,
    };
  }
}
