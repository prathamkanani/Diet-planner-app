import 'package:bloc/bloc.dart';
import 'package:uuid/uuid.dart';
import '../../../domain/entity/profile_entity.dart';
import '../../../domain/repository/profile_repository.dart';
import 'profile_state.dart';

/// The [Cubit] that is responsible for user profile operations.
class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository repository;

  ProfileCubit({required this.repository}) : super(ProfileLoadingState());

  /// It creates the user profile for the first time.
  Future<void> createProfile({required String userId}) async {
    emit(ProfileLoadingState());
    final userProfile = await repository.createUserProfile(userId);
    emit(ProfileEditState(profile: userProfile));
  }

  /// It saves the user profile.
  Future<void> saveProfile({
    required ProfileEntity profile,
    required String seed,
  }) async {
    emit(ProfileLoadingState());
    try {
      await repository.saveUserProfile(profile, seed);
      emit(ProfileEditState(profile: profile));
    } catch (e) {
      emit(ProfileErrorState(e.toString()));
    }
  }

  /// Allows the user to change the avatar.
  void changeAvatar({required ProfileEntity profile}) {
    final String avatarSeed = const Uuid().v4();
    emit(
      ProfileEditState(
        profile: ProfileEntity(userId: profile.userId, avatarUrl: avatarSeed),
      ),
    );
  }
}
