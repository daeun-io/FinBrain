import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finbrain/data/aes_helper.dart';
import 'package:flutter/widgets.dart';

class AiConversationDataSource {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // 상품에 대한 AI 대화 내용 서버에 저장하기
  // Save AI conversation in firestore
  Future<void> saveRequestAndResponse(
    String uid,
    String productNameOrCode,
    String ctg,
    String productName,
    String request,
    String response,
  ) async {
    try {
      final docRef = firestore
          .collection("users")
          .doc(uid)
          .collection("activities")
          .doc("ai_conversation")
          .collection("products")
          .doc(productNameOrCode);
      await docRef.set({"category": ctg, "prdt_name": productName});
      await docRef.collection("chat_history").add({
        "request": AesHelper.encryptText(request),
        "response": AesHelper.encryptText(response),
        "created_at": DateTime.now().toIso8601String(),
      });
    } catch (e) {
      throw Exception("[error] failed to save request and response : $e");
    }
  }

  // 상품 코드나 이름으로 대화 가져오기
  // Fetch AI conversation about product with its code or name
  Future<List<Map<String, dynamic>>> getConversationWithPrdtNmOrCd(
    String uid,
    String productNameOrCode,
  ) async {
    try {      
      final docSnapshot = await firestore
          .collection("users")
          .doc(uid)
          .collection("activities")
          .doc("ai_conversation")
          .collection("products")
          .doc(productNameOrCode)
          .collection("chat_history")
          .orderBy("created_at", descending: false)
          .get();

      if (docSnapshot.docs.isNotEmpty) {
        return docSnapshot.docs.map((doc) => doc.data()).toList();
      } else {
        debugPrint("[empty] comparison text is empty");
        return [];
      }
    } catch (e) {
      throw Exception("[error] failed to fetch messages(chat_history) : $e");
    }
  }
}