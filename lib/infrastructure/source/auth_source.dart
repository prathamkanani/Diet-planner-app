import 'package:supabase_flutter/supabase_flutter.dart';
import '../../application/service/app_data_service.dart';
import '../../application/service/auth_service.dart';
import '../../domain/entity/auth_entity.dart';
import '../../domain/entity/session_entity.dart';
import '../app_injector.dart';

// Defines contracts for authentication operations.
abstract interface class AuthDataSource {
  Future<AuthEntity> signIn(FederatedAuthType type);

  Future<void> signOut(FederatedAuthType type);

  Future<AuthEntity?> getUser();
}

class SupabaseAuthSource implements AuthDataSource {
  final SupabaseClient supabase;
  final FederatedAuthService authService;

  SupabaseAuthSource(this.supabase, this.authService);

  final AppDataService appDataService = locator.get();

  /// Gets user from supabase current session.
  @override
  Future<AuthEntity?> getUser() async {
    final Session? session = supabase.auth.currentSession;
    if (session == null) return null;
    return AuthEntity(userId: session.user.id);
  }

  /// Lets user sign in.
  @override
  Future<AuthEntity> signIn(FederatedAuthType type) async {
    final SessionEntity sessionEntity = await authService.signIn(type);

    // Handing over to supabase.
    final AuthResponse result = await supabase.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: sessionEntity.idToken,
      accessToken: sessionEntity.accessToken,
    );

    // Get the current user.
    final User currentUser = result.user!;

    final response = await supabase
        .from('profiles')
        .select('id')
        .eq('user_id', currentUser.id)
        .maybeSingle();

    appDataService.userId = currentUser.id;
    appDataService.isUserLoggedIn = true;

    // If a user already having an account, logs in and gets the existing plan.
    final res = await supabase
        .from('meal_plan')
        .select('plan_start')
        .eq('user_id', currentUser.id)
        .order('plan_start', ascending: false)
        .limit(1)
        .maybeSingle();
    appDataService.planStartDate = DateTime.tryParse(res?['plan_start']);

    if (response?['id'] != null) {
      return AuthEntity(userId: currentUser.id, isOnboarded: true);
    }

    // Converts supabase user to auth entity.
    return AuthEntity(userId: currentUser.id);
  }

  /// Lets the user sign out from supabase and google.
  @override
  Future<void> signOut(FederatedAuthType type) async {
    await supabase.auth.signOut();
    await authService.signOut(type);
    appDataService.isUserLoggedIn = false;
  }
}
