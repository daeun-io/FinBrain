import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class AiSummaryDataSource {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // AI 대화 내용 고정 여부 업데이트
  // Update whether summary is pinned or not
  Future<void> updateSummaries(
    String uid,
    String productNameOrCd,
    List<Map<String, dynamic>> texts,
    String category,
    String productName,
    bool isPinned,
  ) async {
    try {
      final batch = firestore.batch();

      final docRef = firestore
          .collection(uid)
          .doc("ai_summary")
          .collection("products")
          .doc(productNameOrCd);
      final summariesRef = docRef.collection("chat_summary");
      
      batch.set(
        docRef, 
        {"category": category, "is_pinned": isPinned, "prdt_name": productName}
      );
      
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

  // 상품 코드나 이름으로 AI 대화 요약본 가져오기
  // Get Ai conversation summary with product code or name
  Future<Map<String, dynamic>> getSummariesWithPrdtNmOrCd(
    String uid,
    String productNameOrCd,
  ) async {
    try {
      final docRef = firestore
          .collection(uid)
          .doc("ai_summary")
          .collection("products")
          .doc(productNameOrCd);

      final docSnapshot = await docRef.get();
      final summariesSnapshot = await docRef
          .collection("chat_summary")
          .orderBy("created_at", descending: false)
          .get();

      if (docSnapshot.exists && summariesSnapshot.docs.isNotEmpty) {
        return {
          "category": docSnapshot["category"],
          "is_pinned": docSnapshot["is_pinned"],
          "prdt_name": docSnapshot["prdt_name"],
          "summaries": summariesSnapshot.docs.map((doc) => doc.data()).toList(),
        };
      } else {
        debugPrint("[empty] $productNameOrCd summary list is empty");
        return {};
      }
    } catch (e) {
      throw Exception("[error] failed to fetch $productNameOrCd summaries : $e");
    }
  }

  // 모든 AI 대화 요약 가져오기
  // Get all AI conversation summaries
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
        final productNamesOrCds = docSnapshot.docs.map((doc) => doc.id).toList();
        for (final nmOrCd in productNamesOrCds) {
          final snapshot = await getSummariesWithPrdtNmOrCd(uid, nmOrCd);
          if (snapshot.isNotEmpty) {
            document.add((nmOrCd, snapshot));
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
