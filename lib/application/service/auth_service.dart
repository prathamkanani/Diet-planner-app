import '../../domain/entity/session_entity.dart';

enum FederatedAuthType { google }

abstract interface class FederatedAuthService {
  Future<SessionEntity> signIn(FederatedAuthType type);
  Future<void> signOut(FederatedAuthType type);
}