import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:finbrain/data/aes_helper.dart';
import 'package:finbrain/data/google_auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserDataSource {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // 서버에 프로필 이름과 이메일 저장하기
  // Save display name and email in firestore
  Future<void> saveEmailAndDisplayName(User user) async {
    final userRef = firestore.collection("users").doc(user.uid);
    await userRef.set({
      "display_name": AesHelper.encryptText(user.displayName ?? "성이름"),
      "email": AesHelper.encryptText(user.email!),
      "displayed_isa_guide": false,
    }, SetOptions(merge: true));
  }

  // 탈퇴 시 유저의 모든 데이터 삭제하기
  // Delete all data of user when deleting account
  Future<void> deleteAllDataOfUser(User user) async {
    final functions = FirebaseFunctions.instanceFor(region: "asia-northeast3");
    await functions.httpsCallable("deleteAllUserData").call();
  }

  // 첫 로그인 여부 확인
  // Check if this is the first login
  Future<bool?> isFirstLogin(User? user) async {
    if(user == null || user.email == null || user.displayName == null) return null;
    final userRef = await firestore.collection("users").doc(user.uid).get();
    return !userRef.exists;
  }

  // ISA 가이드를 보였는지 여부 확인
  // Check if isa guide was displayed before
  Future<bool> displayedIsaGuideBefore(User user) async {
    final userRef = await firestore.collection("users").doc(user.uid).get();
    return userRef["displayed_isa_guide"];
  }

  // displayed_isa_guide를 true로 업데이트
  // Update displayed_isa_guide to true
  Future<void> setDisplayedIsaGuideToTrue() async {
    final user = GoogleAuthService.getCurrentUser();
    if(user == null || user.email == null || user.displayName == null) return;
    final userRef = firestore.collection("users").doc(user.uid);
    await userRef.update({"displayed_isa_guide" : true});
  }
}