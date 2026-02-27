import '../../domain/entity/session_entity.dart';

/// This contains all the types of social auths like google, apple, etc.
enum FederatedAuthType { google }

/// This contains
abstract interface class FederatedAuthService {
  Future<SessionEntity> signIn(FederatedAuthType type);

  Future<void> signOut(FederatedAuthType type);
}
