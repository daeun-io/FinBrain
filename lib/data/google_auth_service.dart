import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

// 구글 인증 서비스
class GoogleAuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  static bool isInitialized = false;

  static Future<void> initSignIn() async {
    // 안드로이드를 위해 구글 로그인 초기화
    // Initialize google login for Android
    if (!isInitialized) {
      await _googleSignIn.initialize(
        serverClientId: "1026903577783-nh1ce57ft4mdu5q4nki5tn56j1s877r4.apps.googleusercontent.com",
      );
    }
    isInitialized = true;
  }

  // 구글 로그인
  // Google social login
  Future<UserCredential?> signInWithGoogle() async {
    try {
      // 현재 로그인 되어 있는 경우 로그아웃 후 로그인
      if(_auth.currentUser != null) {
        await _googleSignIn.signOut();
      }
      
      await initSignIn();
      
      final GoogleSignInAccount googleUser = await _googleSignIn.authenticate();

      final idToken = googleUser.authentication.idToken;
      final authorizationClient = googleUser.authorizationClient;
      
      GoogleSignInClientAuthorization? authorization = await authorizationClient.authorizationForScopes(['email', 'profile']);

      final accessToken = authorization?.accessToken;

      final credential = GoogleAuthProvider.credential(
        accessToken: accessToken,
        idToken: idToken,
      );

      final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      final User? user = userCredential.user;
      
      if (user != null && user.email != null && user.displayName != null) {
        return userCredential;
      } else {
        debugPrint('User sign-in failed');
        return null;
      }
    } catch (e) {
      debugPrint('Error signing in with Google: $e');
      return null;
    }
  }

  // 구글 로그아웃
  static Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
      FirebaseFirestore.instance.terminate();
      
      debugPrint('User signed out successfully');
    } catch (e) {
      debugPrint('Error signing out: $e');
    }
  }

  // 현재 접속한 유저 구하기
  static User? getCurrentUser() {
    return _auth.currentUser;
  }
}
