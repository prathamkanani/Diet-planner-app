import 'package:bloc/bloc.dart';
import 'package:uuid/uuid.dart';
import '../../../domain/entity/profile_entity.dart';
import '../../../domain/repository/profile_repository.dart';
import 'profile_state.dart';

/// The [Cubit] that is responsible for user profile operations.
class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository repository;

  ProfileCubit({required this.repository}) : super(ProfileLoadingState());

  ProfileEntity? _savedProfile;

  /// It fetches the user profile, if exists.
  Future<void> getProfile(String userId) async {
    try {
      final userProfile = await repository.getUserProfile(userId);
      _savedProfile = userProfile;
      emit(ProfileSavedState(userProfile));
    } catch (e) {
      emit(ProfileErrorState(e));
    }
  }

  Future<void> onProfileChanged({required ProfileEntity profile}) async {
    if (_savedProfile == null) return;
    try {
      if (_savedProfile == profile) {
        return emit(ProfileSavedState(profile));
      }
      return emit(ProfileEditState(profile));
    } catch (e) {
      emit(ProfileErrorState(e.toString()));
    }
  }

  /// It saves the user profile.
  Future<void> saveProfile({
    required ProfileEntity profile,
  }) async {
    emit(ProfileLoadingState());
    try {
      await repository.saveUserProfile(profile);
      _savedProfile = profile;
      emit(ProfileSavedState(profile));
    } catch (e) {
      emit(ProfileErrorState(e.toString()));
    }
  }

  /// Allows the user to change the avatar.
  void changeAvatar({required ProfileEntity profile}) {
    final String avatarSeed = const Uuid().v4();
    emit(
      ProfileEditState(
        ProfileEntity(userId: profile.userId, avatarUrl: avatarSeed),
      ),
    );
  }
}
