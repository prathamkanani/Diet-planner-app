import '../../../domain/entity/auth_entity.dart';

/// Base state for the [AuthCubit]
sealed class AuthState {}

/// Initial Loading state.
final class AuthLoading extends AuthState {}

/// State when a user is not authenticated.
final class AuthUnauthenticated extends AuthState {}

/// State when a user is authenticated.
///
/// * [authEntity] : The authenticated profile [AuthEntity].
final class AuthAuthenticated extends AuthState {
  final AuthEntity authEntity;
  final bool isOnboarded;

  AuthAuthenticated(this.authEntity, this.isOnboarded);
}

/// State when a user authentication fails.
///
/// * [message] : The error message that is shown.
final class AuthAuthenticationFailed extends AuthState {
  final Object? message;

  AuthAuthenticationFailed({this.message});
}
