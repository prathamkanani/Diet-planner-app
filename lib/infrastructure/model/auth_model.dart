import '../../domain/entity/auth_entity.dart';

/// Data-Transfer Object for the [AuthEntity].
class AuthModel extends AuthEntity {
  const AuthModel({required super.userId});

  /// To convert to the model from its entity.
  factory AuthModel.fromEntity(AuthEntity authEntity) {
    return AuthModel(userId: authEntity.userId);
  }
}