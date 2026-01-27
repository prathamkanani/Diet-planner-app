import '../../../domain/entity/profile_entity.dart';
import '../../domain/repository/profile_repository.dart';
import '../source/profile_source.dart';

/// Concrete implementation of Profile Repository
class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource source;

  ProfileRepositoryImpl(this.source);

  @override
  Future<void> saveUserProfile(ProfileEntity profile, String seed) async {
    await source.saveProfile(profile, seed);
  }

  @override
  Future<void> editUserProfile(ProfileEntity profile) async {
    await source.editProfile(profile);
  }

  @override
  Future<ProfileEntity> getUserProfile(ProfileEntity profile) async {
    final userProfile = await source.getUserProfile(profile);
    return userProfile;
  }

  @override
  Future<ProfileEntity> createUserProfile(ProfileEntity profile) async {
    final userProfile = await source.createProfile(profile);
    return userProfile;
  }
}