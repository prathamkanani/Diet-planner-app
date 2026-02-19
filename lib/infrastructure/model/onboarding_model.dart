import '../../application/logic/onboarding/onboarding_cubit.dart';
import '../../domain/entity/health_habits_entity.dart';
import '../../domain/entity/onboarding_entity.dart';
import '../../domain/entity/profile_entity.dart';
import '../../domain/entity/user_preferences.dart';
import '../app_injector.dart';
import 'user_pref_model.dart';

class OnboardingModel extends OnboardingEntity {
  OnboardingModel({
    required super.profileEntity,
    required super.userPreferences,
  });

  static List<String> habitsToString(List<HealthHabits> healthHabits) {
    final OnboardingCubit cubit = locator.get<OnboardingCubit>();
    return cubit.healthHabits.map((habit) => habit.name).toList();
  }

  static List<HealthHabits> habitsFromString(List<dynamic> healthHabits) {
    return healthHabits
        .map((habit) => HealthHabits.values.byName(habit))
        .toList();
  }

  static String mealPlanningToString(MealPlanning meal) => meal.meal;

  static String activityToString(ActivityLevel activity) => activity.title;

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
      'health_habit': habitsToString(userPreferences.healthHabits),
      'meal_planning': userPreferences.mealPlanning.name,
      'activity': userPreferences.activityLevel.name,
      'country': userPreferences.country,
    };
  }
}
