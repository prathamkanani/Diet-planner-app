import 'package:bloc/bloc.dart';
import '../../../domain/repository/auth_repository.dart';
import 'auth_state.dart';

/// The [Cubit] responsible for authentication related operations.
class AuthCubit extends Cubit<AuthState> {
  /// The [AuthRepository] repository that is needed as a dependency.
  final AuthRepository authRepository;

  AuthCubit({required this.authRepository}) : super(AuthLoading());

  /// Gets the current user, if exists.
  void getUser() async {
    try {
      final authUser = await authRepository.getUser();
      if (authUser != null) {
        return emit(AuthAuthenticated(authUser, authUser.isOnboarded));
      }
      return emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthAuthenticationFailed(message: e.toString()));
    }
  }

  /// Lets the user sign in.
  Future<void> signIn() async {
    try {
      emit(AuthLoading());
      final authUser = await authRepository.signIn();
      if (authUser != null) {
        emit(AuthAuthenticated(authUser, authUser.isOnboarded));
      }
    } catch (e) {
      emit(AuthAuthenticationFailed(message: e.toString()));
    }
  }

  /// Lets the user sign out.
  Future<void> signOut() async {
    try {
      await authRepository.signOut();
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthAuthenticationFailed(message: e.toString()));
    }
  }
}
