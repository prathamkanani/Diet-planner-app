// © Meditab Software 2025

/// Defines contract for application data class that stores and update data
/// across different screens.
///
/// Note: This class is not made `interface` since it holds shared methods as
/// well.
abstract class AppDataService {
  /// Unique identifier of the authenticated user.
  String? userId;

  /// Checks if user has active session or not.
  bool isUserLoggedIn = false;

  /// Storing first meal plan date to know whether to generate or get meal plan.
  DateTime? planStartDate;
}
