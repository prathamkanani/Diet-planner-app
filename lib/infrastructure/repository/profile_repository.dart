import '../../../domain/entity/profile_entity.dart';
import '../../domain/repository/profile_repository.dart';
import '../source/profile_source.dart';

/// Concrete implementation of Profile Repository
class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileSource source;

  ProfileRepositoryImpl(this.source);

  @override
  Future<void> saveUserProfile(ProfileEntity profile) async {
    await source.saveProfile(profile);
  }

  @override
  Future<ProfileEntity> getUserProfile(String userId) async {
    final userProfile = await source.getUserProfile(userId);
    return userProfile;
  }
}
