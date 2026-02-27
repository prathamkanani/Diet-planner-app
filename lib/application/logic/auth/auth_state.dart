import '../../../domain/entity/auth_entity.dart';

/// Base state for the [AuthCubit]
sealed class AuthState {
  const AuthState();
}

/// Initial Loading state.
final class AuthLoading extends AuthState {
  const AuthLoading();
}

/// State when a user is not authenticated.
final class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated();
}

/// State when a user is authenticated.
///
/// * [authEntity] : The authenticated profile [AuthEntity].
final class AuthAuthenticated extends AuthState {
  final AuthEntity authEntity;
  final bool isOnboarded;

  const AuthAuthenticated(this.authEntity, this.isOnboarded);
}

/// State when a user authentication fails.
///
/// * [appError] : The error message that is shown.
final class AuthAuthenticationFailed extends AuthState {
  final Object? error;

  const AuthAuthenticationFailed({required this.error});
}
