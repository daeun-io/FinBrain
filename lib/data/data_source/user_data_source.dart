import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:finbrain/data/aes_helper.dart';
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
    }, SetOptions(merge: true));
  }

  // 탈퇴 시 유저의 모든 데이터 삭제하기
  // Delete all data of user when deleting account
  Future<void> deleteAllDataOfUser(User user) async {
    final functions = FirebaseFunctions.instanceFor(region: "asia-northeast3");
    await functions.httpsCallable("deleteAllUserData").call();
  }

}