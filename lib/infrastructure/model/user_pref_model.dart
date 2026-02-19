import '../../application/logic/onboarding/onboarding_cubit.dart';
import '../../domain/entity/health_habits_entity.dart';
import '../../domain/entity/user_preferences.dart';
import '../app_injector.dart';

class UserPrefModel extends UserPreferences {
  UserPrefModel({
    required super.healthHabits,
    required super.mealPlanning,
    required super.activityLevel,
    required super.mealPref,
    required super.country,
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

  factory UserPrefModel.fromEntity(UserPreferences userPref) {
    return UserPrefModel(
      healthHabits: userPref.healthHabits,
      mealPlanning: userPref.mealPlanning,
      activityLevel: userPref.activityLevel,
      mealPref: userPref.mealPref,
      country: userPref.country,
    );
  }

  factory UserPrefModel.fromJson(
      Map<String, dynamic> json,
      ) {
    return UserPrefModel(
      country: json['country'] as String,
      healthHabits: habitsFromString(json['health_habit']),
      mealPlanning: MealPlanning.values.byName(json['meal_planning'] as String),
      activityLevel: ActivityLevel.values.byName(json['activity'] as String),
      mealPref: MealPreferences.values.byName(json['meal_pref'] as String)
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'health_habit': habitsToString(healthHabits),
      'meal_planning': mealPlanning.name,
      'activity': activityLevel.name,
      'meal_pref': mealPref.name,
      'country': country,
    };
  }
}
