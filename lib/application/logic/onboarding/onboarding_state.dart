import '../../../domain/entity/onboarding_entity.dart';

sealed class OnboardingState {
  const OnboardingState();
}

final class OnboardingLoadingState extends OnboardingState {
  const OnboardingLoadingState();
}

final class OnboardingLoadedState extends OnboardingState {
  final OnboardingEntity onboard;

  const OnboardingLoadedState(this.onboard);
}

final class OnboardingPromptState extends OnboardingState {
  final bool isLoading;
  const OnboardingPromptState(this.isLoading);
}

final class OnboardingErrorState extends OnboardingState {
  final Object? error;

  const OnboardingErrorState(this.error);
}
