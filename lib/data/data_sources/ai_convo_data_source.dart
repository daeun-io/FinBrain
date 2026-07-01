import 'package:cloud_firestore/cloud_firestore.dart';

class AiConversationDataSource {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> createMessagesCollection(String uid, String productName) async {
    try {
      await firestore
          .collection(uid)
          .doc("ai_messages")
          .collection("products")
          .doc(productName)
          .set({});
    } catch (e) {
      print("Error creating messages collection: $e");
    }
  }

  Future<bool> isMessagesCollectionExists(
    String uid,
    String productName,
  ) async {
    try {
      final docSnapshot = await firestore
          .collection(uid)
          .doc("ai_messages")
          .collection("products")
          .doc(productName)
          .get();
      return docSnapshot.exists;
    } catch (e) {
      print("Error checking messages collection existence: $e");
      return false;
    }
  }

  Future<void> updateRequestAndResponse(
    String uid,
    String productName,
    Map<String, String> messages,
  ) async {
    try {
      await firestore
          .collection(uid)
          .doc("ai_messages")
          .collection("products")
          .doc(productName)
          .update(messages);
    } catch (e) {
      print("Error updating request and response: $e");
    }
  }
}
