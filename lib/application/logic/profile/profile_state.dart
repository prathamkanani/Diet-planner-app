import '../../../domain/entity/profile_entity.dart';

/// Base state for Profile [Cubit]
sealed class ProfileState {
  const ProfileState();
}

/// Initial loading profile state.
final class ProfileLoadingState extends ProfileState {
  const ProfileLoadingState();
}

/// Profile edit state.
final class ProfileEditState extends ProfileState {
  final ProfileEntity profile;

  const ProfileEditState(this.profile);
}

final class ProfileSavedState extends ProfileState {
  final ProfileEntity profile;

  const ProfileSavedState(this.profile);
}

final class ProfileSavingState extends ProfileState {
  final ProfileEntity profile;

  const ProfileSavingState(this.profile);
}

final class ProfileLogOutState extends ProfileState {
  const ProfileLogOutState();
}

/// Error state.
final class ProfileErrorState extends ProfileState {
  final Object? message;

  ProfileErrorState(this.message);
}
