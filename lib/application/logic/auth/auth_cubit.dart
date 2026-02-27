import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entity/auth_entity.dart';
import '../../../domain/repository/auth_repository.dart';
import 'auth_state.dart';

/// The [Cubit] responsible for authentication related operations.
class AuthCubit extends Cubit<AuthState> {
  /// The [AuthRepository] repository that is needed as a dependency.
  final AuthRepository authRepository;

  AuthCubit({required this.authRepository}) : super(const AuthLoading());

  /// Gets the current user, if exists.
  void getUser() async {
    try {
      final authUser = await authRepository.getUser();
      return authUser != null
          ? emit(AuthAuthenticated(authUser, authUser.isOnboarded))
          : emit(const AuthUnauthenticated());
    } catch (e) {
      emit(AuthAuthenticationFailed(error: e));
    }
  }

  /// Lets the user sign in.
  Future<void> signIn() async {
    try {
      emit(const AuthLoading());
      final AuthEntity authUser = await authRepository.signIn();
      return emit(AuthAuthenticated(authUser, authUser.isOnboarded));
    } catch (e) {
      emit(AuthAuthenticationFailed(error: e));
    }
  }

  /// Lets the user sign out.
  Future<void> signOut() async {
    try {
      await authRepository.signOut();
      return emit(const AuthUnauthenticated());
    } catch (e) {
      emit(AuthAuthenticationFailed(error: e));
    }
  }
}
