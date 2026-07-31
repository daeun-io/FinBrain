import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class PrivacyPoliciesDataSource {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  // 현재 개인정보 처리방침 불러오기
  // Fetch current privacy policy
  Future<String> getCurrentPolicy() async{
    final docSnapshot = await firestore
        .collection("privacy_policies")
        .doc("2026.07.31")
        .get();
    if (docSnapshot.exists) {
      final data = docSnapshot.data();
      return data!.values.first.toString();
    } else {
      debugPrint("[empty] privacy policy list is empty");
      return "";
    }
  }
}