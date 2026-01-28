import '../entity/onboarding_entity.dart';

abstract interface class OnboardingRepository {
  Future<OnboardingEntity> saveOnboardingDetails();
}