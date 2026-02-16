import '../../application/logic/onboarding/onboarding_cubit.dart';
import '../../domain/entity/health_habits_entity.dart';
import '../../domain/entity/onboarding_entity.dart';
import '../../domain/entity/profile_entity.dart';
import '../app_injector.dart';

class OnboardingModel extends OnboardingEntity {
  OnboardingModel({
    required super.country,
    required super.profileEntity,
    required super.healthHabits,
    required super.mealPlanning,
    required super.activityLevel,
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
      country: entity.country,
      profileEntity: entity.profileEntity,
      healthHabits: entity.healthHabits,
      mealPlanning: entity.mealPlanning,
      activityLevel: entity.activityLevel,
    );
  }

  factory OnboardingModel.fromJson(
    Map<String, dynamic> json,
    ProfileEntity? profile,
  ) {
    return OnboardingModel(
      country: json['country'] as String,
      profileEntity: profile!,
      healthHabits: habitsFromString(json['health_habit']),
      mealPlanning: MealPlanning.values.byName(json['meal_planning'] as String),
      activityLevel: ActivityLevel.values.byName(json['activity'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': profileEntity.userId,
      'health_habit': habitsToString(healthHabits),
      'meal_planning': mealPlanning.name,
      'activity': activityLevel.name,
      'country': country,
    };
  }
}
