import '../../domain/entity/user_preferences.dart';
import '../extension/meal_pref_extension.dart';
import '../utils/helpers.dart';

class UserPrefModel extends UserPreferences {
  UserPrefModel({
    required super.healthHabits,
    required super.mealPlanning,
    required super.activityLevel,
    required super.mealPref,
    required super.country,
  });

  factory UserPrefModel.fromEntity(UserPreferences userPref) {
    return UserPrefModel(
      healthHabits: userPref.healthHabits,
      mealPlanning: userPref.mealPlanning,
      activityLevel: userPref.activityLevel,
      mealPref: userPref.mealPref,
      country: userPref.country,
    );
  }

  factory UserPrefModel.fromJson(Map<String, dynamic> json) {
    return UserPrefModel(
      country: json['country'] as String,
      healthHabits: habitsFromDb(json['health_habit']),
      mealPlanning: MealPlanning.values.byName(json['meal_planning'] as String),
      activityLevel: ActivityLevel.values.byName(json['activity'] as String),
      mealPref: MealPrefDbMapper.fromDb(json['meal_pref'] as String),
    );
  }
}
