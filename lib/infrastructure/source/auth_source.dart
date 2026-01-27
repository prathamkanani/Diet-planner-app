import 'package:supabase_flutter/supabase_flutter.dart';
import '../../application/service/auth_service.dart';
import '../../domain/entity/profile_entity.dart';
import '../../domain/entity/session_entity.dart';
import '../model/profile_model.dart';

// Defines contracts for authentication operations.
abstract interface class AuthDataSource {
  Future<ProfileEntity?> signIn(FederatedAuthType type);

  Future<void> signOut(FederatedAuthType type);

  ProfileEntity? getUser();
}

class SupabaseAuthSource implements AuthDataSource {
  final SupabaseClient supabase;
  final FederatedAuthService authService;

  SupabaseAuthSource(this.supabase, this.authService);

  /// Gets user from supabase current session.
  @override
  ProfileEntity? getUser() {
    final Session? session = supabase.auth.currentSession;
    if (session == null) return null;
    return ProfileEntity(userId: session.user.id);
  }

  /// Lets user sign in.
  @override
  Future<ProfileEntity?> signIn(FederatedAuthType type) async {
    final SessionEntity sessionEntity = await authService.signIn(type);

    // Handing over to supabase.
    final AuthResponse result = await supabase.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: sessionEntity.idToken,
      accessToken: sessionEntity.accessToken,
    );

    // Get the current user.
    final User currentUser = result.user!;

    // Converts supabase's user to profile entity.
    return ProfileModel.fromSupabaseUserAndEntity(currentUser, null, '');
  }

  /// Lets the user sign out from supabase and google.
  @override
  Future<void> signOut(FederatedAuthType type) async {
    await supabase.auth.signOut();
    await authService.signOut(type);
  }
}
