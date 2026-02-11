import '../entity/onboarding_entity.dart';

abstract interface class OnboardingRepository {
  /// This saves the details entered by the user.
  Future<OnboardingEntity> saveOnboardingDetails(OnboardingEntity onboard);

  /// This generates meal by providing onboarding user info.
  Future<String?> generateMeal(OnboardingEntity onboard);
}