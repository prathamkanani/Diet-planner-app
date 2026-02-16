/// Session entity for authentication using [idToken] and [accessToken]
class SessionEntity {
  final String idToken;
  final String accessToken;

  const SessionEntity({required this.idToken, required this.accessToken});
}