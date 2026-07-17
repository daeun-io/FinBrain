import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class AiConversationDataSource {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> saveRequestAndResponse(
    String uid,
    String productName,
    String ctg,
    String request,
    String response,
  ) async {
    try {
      final docRef = firestore
          .collection(uid)
          .doc("ai_conversation")
          .collection("products")
          .doc(productName);
      await docRef.set({"category": ctg});
      await docRef.collection("chat_history").add({
        "request": request,
        "response": response,
        "created_at": DateTime.now().toIso8601String(),
      });
    } catch (e) {
      throw Exception("[error] failed to save request and response : $e");
    }
  }

  Future<List<Map<String, dynamic>>> getConversationWithPrdtNm(
    String uid,
    String productName,
  ) async {
    try {
      final docSnapshot = await firestore
          .collection(uid)
          .doc("ai_conversation")
          .collection("products")
          .doc(productName)
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
