import '../../../domain/entity/profile_entity.dart';

/// Base state for Profile [Cubit]
sealed class ProfileState {}

/// Initial loading profile state.
final class ProfileLoadingState extends ProfileState {}

/// Profile edit state.
final class ProfileEditState extends ProfileState {
  final ProfileEntity profile;
  ProfileEditState({required this.profile});
}

/// Error state.
final class ProfileErrorState extends ProfileState {
  final Object? message;
  ProfileErrorState(this.message);
}