import '../../domain/entity/auth_entity.dart';
import '../../domain/entity/profile_entity.dart';

class AuthModel extends AuthEntity {
  const AuthModel({required super.userId});

  factory AuthModel.fromEntity(AuthEntity authEntity) {
    return AuthModel(userId: authEntity.userId);
  }

  ProfileEntity toProfileEntity(AuthEntity auth, String seed) {
    return ProfileEntity(userId: auth.userId, avatarUrl: seed);
  }
}