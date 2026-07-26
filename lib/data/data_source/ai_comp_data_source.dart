import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finbrain/product_categories.dart';
import 'package:flutter/rendering.dart';

class AiCompDataSource {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // 저장소에 비교 글 저장하기
  // Save a single comparison text in firestore
  Future<void> saveComparisonText(
    String uid,
    String tag,
    String text,
    ProductCategory ctg,
    String prdtNames, [
    bool? isPinned,
  ]) async {
    try {
      await firestore
          .collection(uid)
          .doc("ai_comparison")
          .collection("products")
          .doc(tag)
          .set({
            "category": ctg.toString(),
            "created_at": DateTime.now(),
            "comp_text": text,
            "is_pinned": isPinned ?? false,
            "prdt_names": prdtNames,
          });
    } catch (e) {
      debugPrint("[error] failed to save comparison text : $e");
      throw Exception("[error] failed to save comparison text : $e");
    }
  }

  // 상품 코드나 이름들로 비교 글 가져오기
  // Get a comparison text with product codes or names
  Future<Map<String, dynamic>> getComparisonTextWithTag(
    String uid,
    String tag,
  ) async {
    try {
      final docSnapshot = await firestore
          .collection(uid)
          .doc("ai_comparison")
          .collection("products")
          .doc(tag)
          .get();

      if (docSnapshot.exists) {
        return docSnapshot.data() as Map<String, dynamic>;
      } else {
        debugPrint("[empty] $tag comparison text is empty");
        return {};
      }
    } catch (e) {
      throw Exception("[error] failed to fetch comparison text : $e");
    }
  }

  // 모든 비교 글 가져오기
  // Get all comparison texts
  Future<List<(String, Map<String, dynamic>)>> getComparisonTexts(
    String uid,
  ) async {
    try {
      final docSnapshot = await firestore
          .collection(uid)
          .doc("ai_comparison")
          .collection("products")
          .get();

      if (docSnapshot.docs.isNotEmpty) {
        final List<(String, Map<String, dynamic>)> document = [];
        final products = docSnapshot.docs.map((doc) => doc.id).toList();
        for (final tag in products) {
          final snapshot = await getComparisonTextWithTag(uid, tag);
          if (snapshot.isNotEmpty) {
            document.add((tag, snapshot));
          }
        }
        return document;
      } else {
        debugPrint("[empty] all comparison texts are empty");
        return [];
      }
    } catch (e) {
      throw Exception("[error] failed to fetch all comparison texts : $e");
    }
  }
}
