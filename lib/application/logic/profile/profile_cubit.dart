import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import '../../../domain/entity/profile_entity.dart';
import '../../../domain/repository/auth_repository.dart';
import '../../../domain/repository/profile_repository.dart';
import '../../../infrastructure/model/profile_model.dart';
import 'profile_state.dart';

/// The [Cubit] that is responsible for user profile operations.
class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository repository;
  final AuthRepository authRepository;

  ProfileCubit({required this.repository, required this.authRepository})
    : super(const ProfileLoadingState());

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

  /// This checks whether any changes were made to the existing or saved profile.
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
  Future<void> saveProfile({required ProfileEntity profile}) async {
    emit(const ProfileLoadingState());
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
        ProfileModel.fromEntity(entity: profile, email: null, seed: avatarSeed),
      ),
    );
  }

  /// This allows the user to log out from the app.
  Future<void> logOut() async {
    try {
      await authRepository.signOut();
      emit(const ProfileLogOutState());
    } catch (e) {
      emit(ProfileErrorState(e));
    }
  }
}
