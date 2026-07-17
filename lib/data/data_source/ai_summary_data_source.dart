import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class AiSummaryDataSource {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> updateSummaries(
    String uid,
    String productName,
    List<Map<String, dynamic>> texts,
    String category,
    bool isPinned,
  ) async {
    try {
      final batch = firestore.batch();
      final docRef = firestore
          .collection(uid)
          .doc("ai_summary")
          .collection("products")
          .doc(productName);
      final summariesRef = docRef.collection("chat_summary");
      await docRef.set({"category": category, "is_pinned": isPinned});
      for (final text in texts) {
        final newDocRef = summariesRef.doc();
        batch.set(newDocRef, {
          "summary": text["summary"],
          "created_at": text["created_at"],
        });
      }
      await batch.commit();
    } catch (e) {
      throw Exception("[error] failed to update summaries : $e");
    }
  }

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
          .orderBy("created_at", descending: false)
          .get();

      if (docSnapshot.exists && summariesSnapshot.docs.isNotEmpty) {
        return {
          "category": docSnapshot["category"],
          "is_pinned": docSnapshot["is_pinned"],
          "summaries": summariesSnapshot.docs.map((doc) => doc.data()).toList(),
        };
      } else {
        debugPrint("[empty] $productName summary list is empty");
        return {};
      }
    } catch (e) {
      throw Exception("[error] failed to fetch $productName summaries : $e");
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
        debugPrint("[empty] summaires list is empty");
        return [];
      }
    } catch (e) {
      throw Exception("[error] failed to fetch all summaries : $e");
    }
  }
}
