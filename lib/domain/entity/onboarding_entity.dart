import 'profile_entity.dart';
import 'user_preferences.dart';

/// The entity that is created when a user is onboarded.
class OnboardingEntity {
  final ProfileEntity profileEntity;

  final UserPreferences userPreferences;

  const OnboardingEntity({
    required this.profileEntity,
    required this.userPreferences
  });
}
