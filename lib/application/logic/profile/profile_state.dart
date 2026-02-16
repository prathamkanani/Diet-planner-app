import '../../../domain/entity/profile_entity.dart';

/// Base state for Profile [Cubit]
sealed class ProfileState {
  final ProfileEntity profile;

  const ProfileState(this.profile);
}

/// Initial loading profile state.
final class ProfileLoadingState extends ProfileState {
  ProfileLoadingState() : super(ProfileEntity.empty());
}

/// Profile edit state.
final class ProfileEditState extends ProfileState {
  const ProfileEditState(super.profile);
}

final class ProfileSavedState extends ProfileState {
  const ProfileSavedState(super.profile);
}

/// Error state.
final class ProfileErrorState extends ProfileState {
  final Object? message;

  ProfileErrorState(this.message) : super(ProfileEntity.empty());
}
