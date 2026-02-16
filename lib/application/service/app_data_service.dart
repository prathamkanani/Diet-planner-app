// © Meditab Software 2025

import '../../domain/entity/onboarding_entity.dart';
import '../../domain/entity/profile_entity.dart';
import '../../infrastructure/utils/types.dart';

/// Defines contract for application data class that stores and update data
/// across different screens.
///
/// Note: This class is not made `interface` since it holds shared methods as
/// well.
abstract class AppDataService {
  /// Unique identifier of the authenticated user.
  String? userId;

  /// Profile of the authenticated user.
  ProfileEntity? profile;

  /// Onboarding Entity of the authenticated user.
  OnboardingEntity? onboarding;

  /// MealList from AI generated JSON data.
  MealList? mealList;

  /// Stores AI generated meal data in JSON format.
  JsonList? jsonList;

  /// Storing first meal plan date to know whether to generate or get meal plan.
  DateTime? planStartDate;

  /// Stores which week's plan does a meal belong to.
  String? mealPlanId;

  /// A new user or a returning user.
  bool? isNewUser;

  /// Meal log ids for each type
  String? breakfastLogId;
  String? lunchLogId;
  String? dinnerLogId;
}
