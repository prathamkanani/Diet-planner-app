import '../../application/service/auth_service.dart';
import '../../domain/entity/auth_entity.dart';
import '../../domain/repository/auth_repository.dart';
import '../source/auth_source.dart';

/// Concrete implementation of the authentication repository.
///
/// * [source] : The source that is called by the repository.
class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource source;

  const AuthRepositoryImpl(this.source);

  @override
  Future<AuthEntity?> getUser() {
    return source.getUser();
  }

  /// This method signs in the user.
  @override
  Future<AuthEntity> signIn() async {
    // Signing in using google auth provider.
    return await source.signIn(FederatedAuthType.google);
  }

  @override
  Future<void> signOut() async {
    // Signing out using google auth provider.
    await source.signOut(FederatedAuthType.google);
  }
}
