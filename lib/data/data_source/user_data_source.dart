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
      "read_product_detail_tutorial": false,
      "read_isa_tutorial": false,
      "read_ai_comp_tutorial": false,
      "ai_tone": "설명적으로",
    }, SetOptions(merge: true));
  }

  // 유저 관련 설정이 존재하지 않으면 저장
  // Set user options if they do not exist
  Future<void> setUserOptions(User user) async {
    final userRef = firestore.collection("users").doc(user.uid);
    final userRefDoc = await userRef.get();
    final userData = userRefDoc.data();
    if (userData == null) {
      await userRef.set({
        "display_name": AesHelper.encryptText(user.displayName ?? "성이름"),
        "email": AesHelper.encryptText(user.email!),
        "read_product_detail_tutorial": false,
        "read_isa_tutorial": false,
        "read_ai_comp_tutorial": false,
        "ai_tone": "설명적으로",
      }, SetOptions(merge: true));
    } else {
      if (!userData.containsKey("read_product_detail_tutorial")) {
        await userRef.set({
          "read_product_detail_tutorial": false,
        }, SetOptions(merge: true));
      }
      if (!userData.containsKey("read_isa_tutorial")) {
        await userRef.set({
          "read_isa_tutorial": false,
        }, SetOptions(merge: true));
      }
      if (!userData.containsKey("read_ai_comp_tutorial")) {
        await userRef.set({
          "read_ai_comp_tutorial": false,
        }, SetOptions(merge: true));
      }
      if (!userData.containsKey("ai_tone")) {
        await userRef.set({"ai_tone": "설명적으로"}, SetOptions(merge: true));
      }
    }
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
    if (user == null || user.email == null || user.displayName == null)
      return null;
    final userRef = await firestore.collection("users").doc(user.uid).get();
    return !userRef.exists;
  }

  // 튜토리얼을 봤는가
  // Check if user read tutorials
  Future<bool> readProductDetailTutorial(User user) async {
    final userRef = await firestore.collection("users").doc(user.uid).get();
    return userRef["read_product_detail_tutorial"];
  }

  Future<bool> readIsaTutorial(User user) async {
    final userRef = await firestore.collection("users").doc(user.uid).get();
    return userRef["read_isa_tutorial"];
  }

  Future<bool> readAiCompTutorial(User user) async {
    final userRef = await firestore.collection("users").doc(user.uid).get();
    return userRef["read_ai_comp_tutorial"];
  }

  // 튜토리얼 패러미터를 true로 업데이트
  // Update tutorial params to true
  Future<void> setReadProductDetailTutorialToTrue() async {
    final user = GoogleAuthService.getCurrentUser();
    if (user == null || user.email == null || user.displayName == null) return;
    final userRef = firestore.collection("users").doc(user.uid);
    await userRef.update({"read_product_detail_tutorial": true});
  }

  Future<void> setReadIsaTutorialToTrue() async {
    final user = GoogleAuthService.getCurrentUser();
    if (user == null || user.email == null || user.displayName == null) return;
    final userRef = firestore.collection("users").doc(user.uid);
    await userRef.update({"read_isa_tutorial": true});
  }

  Future<void> setReadAiCompTutorialToValue(bool value) async {
    final user = GoogleAuthService.getCurrentUser();
    if (user == null || user.email == null || user.displayName == null) return;
    final userRef = firestore.collection("users").doc(user.uid);
    await userRef.update({"read_ai_comp_tutorial": value});
  }

  // 저장된 AI 어조 불러오기
  // Fetch AI tone in Firestore
  Future<String?> getAiTone() async {
    final user = GoogleAuthService.getCurrentUser();
    if (user == null || user.email == null || user.displayName == null)
      return null;
    final userRef = await firestore.collection("users").doc(user.uid).get();
    return userRef["ai_tone"];
  }

  // 저장된 AI 어조 불러오기
  // Fetch AI tone in Firestore
  Future<void> setAiTone(String tone) async {
    final user = GoogleAuthService.getCurrentUser();
    if (user == null || user.email == null || user.displayName == null) return;
    final userRef = firestore.collection("users").doc(user.uid);
    await userRef.update({"ai_tone": tone});
  }
}
