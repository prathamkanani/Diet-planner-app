import '../../domain/entity/onboarding_entity.dart';
import '../../domain/repository/onboarding_repository.dart';
import '../source/onboard_source.dart';

class OnboardingRepositoryImpl implements OnboardingRepository {
  final OnboardingSource source;

  const OnboardingRepositoryImpl(this.source);

  @override
  Future<OnboardingEntity> saveOnboardingDetails(
    OnboardingEntity onboard,
  ) async {
    return await source.saveOnboardingDetails(onboard);
  }

  @override
  Future<String?> generateMeal(OnboardingEntity onboard) async {
    return await source.generateMealAI(onboard);
  }
}
