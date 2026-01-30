import '../../../domain/entity/onboarding_entity.dart';

sealed class OnboardingState {
  const OnboardingState();
}

class OnboardingLoadingState extends OnboardingState {
  const OnboardingLoadingState();
}

class OnboardingLoadedState extends OnboardingState {
  final OnboardingEntity onboard;

  const OnboardingLoadedState(this.onboard);
}

class OnboardingPromptState extends OnboardingState {
  final bool isLoading;
  const OnboardingPromptState(this.isLoading);
}

class OnboardingErrorState extends OnboardingState {
  final Object? error;

  const OnboardingErrorState(this.error);
}
