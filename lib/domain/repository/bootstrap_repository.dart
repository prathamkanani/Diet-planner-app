/// Defines contract for bootstrap logic.
abstract interface class BootstrapRepository {
  /// Checks whether a user is authenticated or not.
  bool isUserAuthenticated();

  /// Checks whether an authenticated user has been onboarded or not.
  Future<bool> isOnboardingCompleted();
}