import '../../domain/entity/onboarding_entity.dart';
import '../../domain/entity/user_preferences.dart';
import '../../domain/repository/onboarding_repository.dart';
import '../source/onboard_source.dart';
import '../utils/types.dart';

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
  Future<JsonList> generateMeal(
    UserPreferences userPrefs,
    DateTime date,
  ) async {
    return await source.generateMealAI(userPrefs, date);
  }

  @override
  Future<void> saveGeneratedMeal(JsonList jsonList, DateTime date) async {
    await source.saveGeneratedPlan(jsonList, date);
  }
}
