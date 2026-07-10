import 'package:cloud_firestore/cloud_firestore.dart';

class AiSummaryDataSource {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> getSummariesWithPrdtNm(
    String uid,
    String productName,
  ) async {
    try {
      final docRef = firestore
          .collection(uid)
          .doc("ai_summary")
          .collection("products")
          .doc(productName);

      final docSnapshot = await docRef.get();
      final summariesSnapshot = await docRef
          .collection("chat_summary")
          .orderBy("createdAt", descending: false)
          .get();

      if (docSnapshot.exists && summariesSnapshot.docs.isNotEmpty) {
        return {
          "category": docSnapshot["category"],
          "summaries": summariesSnapshot.docs.map((doc) => doc.data()).toList(),
        };
      } else {
        print("Error no document or summaries");
        return {};
      }
      // if (docSnapshot.docs.isNotEmpty) {
      // return docSnapshot.docs.map((doc) => doc.data()).toList();
      // } else {
      // print("Error document is empty");
      // return [];
      // }
    } catch (e) {
      print("Error fetching summaries with $productName: $e");
      return {};
    }
  }

  Future<List<(String, Map<String, dynamic>)>> getAllSummaries(
    String uid,
  ) async {
    try {
      final docSnapshot = await firestore
          .collection(uid)
          .doc("ai_summary")
          .collection("products")
          .get();

      if (docSnapshot.docs.isNotEmpty) {
        final List<(String, Map<String, dynamic>)> document = [];
        final productNames = docSnapshot.docs.map((doc) => doc.id).toList();
        for (final name in productNames) {
          final snapshot = await getSummariesWithPrdtNm(uid, name);
          if (snapshot.isNotEmpty) {
            document.add((name, snapshot));
          }
        }
        return document;
      } else {
        print("Error document is empty");
        return [];
      }
    } catch (e) {
      print("Error fetching all summaries: $e");
      return [];
    }
  }
}
