import '../../infrastructure/utils/types.dart';
import '../entity/onboarding_entity.dart';

abstract interface class OnboardingRepository {
  /// This saves the details entered by the user.
  Future<OnboardingEntity> saveOnboardingDetails(OnboardingEntity onboard);

  /// This generates meal by providing onboarding user info.
  Future<JsonList> generateMeal(OnboardingEntity onboard);

  /// Stores the generated meal plan.
  ///
  /// It is typically called once the onboarding is completed
  /// or the existing meal plan expires.
  Future<void> saveGeneratedMeal(JsonList jsonList);
}