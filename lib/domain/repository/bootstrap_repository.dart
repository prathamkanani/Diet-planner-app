abstract interface class BootstrapRepository {
  /// Checks whether a user is authenticated or not.
  bool fetchAuthStatus();

  /// Checks whether an authenticated user has been onboarded or not.
  Future<bool> fetchOnboardingStatus();
}