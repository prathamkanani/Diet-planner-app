import '../entity/onboarding_entity.dart';

abstract interface class OnboardingRepository {
  /// This saves the details entered by the user.
  Future<OnboardingEntity> saveOnboardingDetails(OnboardingEntity onboard);

  /// This sends the data to AI to generate meal plans.
  Stream<Map<String, dynamic>> sendPrompt(OnboardingEntity onboard);
}