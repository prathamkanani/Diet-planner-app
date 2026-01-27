import '../entity/profile_entity.dart';

/// Defines the contracts for User Profile
abstract interface class ProfileRepository {
  /// Gets user profile
  Future<ProfileEntity> getUserProfile(ProfileEntity profile);

  /// Creates a user profile at the time of first sign up.
  Future<ProfileEntity> createUserProfile(ProfileEntity profile);

  /// Saves the user profile to the database
  Future<void> saveUserProfile(ProfileEntity profile, String seed);

  /// Enables editing of the user profile
  Future<void> editUserProfile(ProfileEntity profile);
}