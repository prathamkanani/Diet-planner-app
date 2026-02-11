abstract interface class BootstrapRepository {
  bool isUserAuthenticated();

  Future<bool> isOnboardingCompleted();
}