/// Auth entity used for authentication
class AuthEntity {
  /// The user id generated for a user.
  final String userId;

  /// The email of the user.
  final String? email;

  /// This checks whether the user is onboarded or not.
  final bool isOnboarded;

  const AuthEntity({
    required this.userId,
    this.email,
    this.isOnboarded = false,
  });
}
