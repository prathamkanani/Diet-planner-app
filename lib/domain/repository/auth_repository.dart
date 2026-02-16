import '../entity/auth_entity.dart';

/// Defines contracts for authentication.
abstract interface class AuthRepository {
  /// Gets user details from the current session.
  Future<AuthEntity?> getUser();

  /// Lets the user sign in.
  Future<AuthEntity?> signIn();

  /// Signs out the user.
  Future<void> signOut();
}