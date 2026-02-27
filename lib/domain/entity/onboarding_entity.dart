import 'profile_entity.dart';
import 'user_preferences.dart';

/// The entity that is created when a user is onboarded.
class OnboardingEntity {
  /// User details asked during onboarding.
  final ProfileEntity profileEntity;

  /// User preferences required for planning meals.
  final UserPreferences userPreferences;

  const OnboardingEntity({
    required this.profileEntity,
    required this.userPreferences
  });
}
