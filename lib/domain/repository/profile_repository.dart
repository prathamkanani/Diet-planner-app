import '../entity/profile_entity.dart';

/// Defines the contracts for User Profile
abstract interface class ProfileRepository {
  /// Gets user profile
  Future<ProfileEntity> getUserProfile(String userId);

  /// Saves the user profile to the database
  Future<void> saveUserProfile(ProfileEntity profile);

  /// Enables editing of the user profile
  Future<ProfileEntity> editUserProfile(ProfileEntity profile);
}