// © Meditab Software 2025


/// Defines contract for application data class that stores and update data
/// across different screens.
///
/// Note: This class is not made `interface` since it holds shared methods as
/// well.
abstract class AppDataService {
  /// Unique identifier of the authenticated user.
  String? userId;
}
