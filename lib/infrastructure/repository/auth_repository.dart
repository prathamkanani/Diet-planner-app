import '../../application/service/auth_service.dart';
import '../../domain/entity/profile_entity.dart';
import '../../domain/repository/auth_repository.dart';
import '../source/auth_source.dart';

/// Concrete implementation of the authentication repository.
///
/// * [source] : The source that is called by the repository.
class AuthRepositoryImpl implements AuthRepository {
  final SupabaseAuthSource source;

  AuthRepositoryImpl(this.source);

  @override
  ProfileEntity? getUser() {
    return source.getUser();
  }

  /// This method signs in the user.
  @override
  Future<ProfileEntity?> signIn() async {
    // Signing in using google auth provider.
    final user = await source.signIn(FederatedAuthType.google);
    return user;
  }

  @override
  Future<void> signOut() async {
    // Signing out using google auth provider.
    await source.signOut(FederatedAuthType.google);
  }
}