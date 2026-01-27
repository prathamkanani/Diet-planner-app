import '../entity/profile_entity.dart';

/// Defines contracts for authentication.
abstract interface class AuthRepository {
  /// Gets user details from the current session.
  ProfileEntity? getUser();

  /// Lets the user sign in.
  Future<ProfileEntity?> signIn();

  /// Signs out the user.
  Future<void> signOut();
}