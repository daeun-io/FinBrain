import 'package:cloud_firestore/cloud_firestore.dart';

class AiConversationDataSource {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> createMessagesCollection(String uid, String productName) async {
    try {
      await firestore
          .collection(uid)
          .doc("ai_conversation")
          .collection("products")
          .doc(productName)
          .collection("chat_history");
    } catch (e) {
      print("Error creating conversation collection: $e");
    }
  }

  Future<bool> isMessagesCollectionExists(
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
          .limit(1)
          .get();
      return docSnapshot.docs.isNotEmpty;
    } catch (e) {
      print("Error checking conversation collection existence: $e");
      return false;
    }
  }

  Future<void> saveRequestAndResponse(
    String uid,
    String productName,
    String request,
    String response,
  ) async {
    try {
      await firestore
          .collection(uid)
          .doc("ai_conversation")
          .collection("products")
          .doc(productName)
          .collection("chat_history")
          .add({
            "request": request,
            "response": response,
            "created_at": DateTime.now().toIso8601String(),
          });
    } catch (e) {
      print("Error saving request and response: $e");
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
        return [];
      }
    } catch (e) {
      print("Error fetching messages: $e");
      return [];
    }
  }
}
