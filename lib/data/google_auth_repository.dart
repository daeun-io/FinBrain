import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  static bool isInitialized = false;

  static Future<void> initSignIn() async {
    // for Android
    if (!isInitialized) {
      await _googleSignIn.initialize(
        serverClientId: "1026903577783-nh1ce57ft4mdu5q4nki5tn56j1s877r4.apps.googleusercontent.com",
      );
    }
    isInitialized = true;
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      await initSignIn();
  
      final GoogleSignInAccount googleUser = await _googleSignIn.authenticate();

      final idToken = googleUser.authentication.idToken;
      final authorizationClient = googleUser.authorizationClient;
      
      GoogleSignInClientAuthorization? authorization = await authorizationClient.authorizationForScopes(['email', 'profile']);

      final accessToken = authorization?.accessToken;
      if(accessToken == null){
        final authorization2 = await authorizationClient.authorizationForScopes(['email', 'profile']);

        if(authorization2?.accessToken == null){
          print('Access token is null');
          return null;
        }
        authorization = authorization2;
      }

      final credential = GoogleAuthProvider.credential(
        accessToken: accessToken,
        idToken: idToken,
      );

      final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      final User? user = userCredential.user;
      if (user != null) {
        print('User signed in: ${user.displayName}, ${user.email}');
        return userCredential;
      } else {
        print('User sign-in failed');
        return null;
      }
    } catch (e) {
      print('Error signing in with Google: $e');
      return null;
    }
  }

  static Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
      print('User signed out successfully');
    } catch (e) {
      print('Error signing out: $e');
    }
  }

  static User? getCurrentUser() {
    return _auth.currentUser;
  }
}
