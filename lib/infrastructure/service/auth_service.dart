import 'package:google_sign_in/google_sign_in.dart';
import '../../application/service/auth_service.dart';
import '../../domain/entity/session_entity.dart';
import '../../env.dart';

class AuthService implements FederatedAuthService {

  @override
  Future<SessionEntity> signIn(FederatedAuthType type) async {
    if(type == FederatedAuthType.google){
      final GoogleSignIn googleSignIn = GoogleSignIn.instance;

      // Initializing the Google sign in.
      await googleSignIn.initialize(
        serverClientId: webClientId,
        clientId: iOSClientId,
      );

      // Perform the sign in.
      // This opens native google account picker.
      final GoogleSignInAccount googleAccount = await googleSignIn
          .authenticate();

      // This requests explicit permission from
      // user to access their email and profile.
      final GoogleSignInClientAuthorization? googleAuthorization =
      await googleAccount.authorizationClient.authorizationForScopes([
        'email',
      ]);

      // Extracting the tokens.
      final GoogleSignInAuthentication googleAuthentication =
          googleAccount.authentication;
      final String? idToken = googleAuthentication.idToken;
      final String? accessToken = googleAuthorization?.accessToken;

      if (idToken == null) {
        throw 'No ID Token found.';
      }

      return SessionEntity(idToken: idToken, accessToken: accessToken ?? '');
    }

    return const SessionEntity(idToken: '', accessToken: '');
  }

  @override
  Future<void> signOut(FederatedAuthType type) async {
    if(type == FederatedAuthType.google) {
      final GoogleSignIn googleSignIn = GoogleSignIn.instance;
      googleSignIn.signOut();
    }
  }
}