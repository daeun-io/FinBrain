import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finbrain/data/converter.dart';
import 'package:finbrain/data/data_source/ai_comp_data_source.dart';
import 'package:finbrain/data/model/entities/ai_record.dart';
import 'package:finbrain/product_categories.dart';
import 'package:flutter/widgets.dart';

// AI 비교 텍스트 레포지토리
// AI Comparison Repository
class AiCompRepository {
  final dataStore = AiCompDataSource();

  // 저장소에 비교 글 저장하기
  // Save a single comparison text in firestore
  Future<void> saveComparisonText(
    String uid,
    String products,
    String text,
    ProductCategory ctg,
    String prdtNames, [
    bool? isPinned,
  ]) async {
    try {
      await dataStore.saveComparisonText(uid, products, text, ctg, prdtNames, isPinned);
    } catch (e) {
      throw Exception("[error] failed to save comparison text : $e");
    }
  }

  // 상품 코드나 이름들로 비교 글 가져오기
  // Get a comparison text with product codes or names
  Future<List<AiRecord>> getComparisonTexts(String uid) async {
    try {
      final texts = await dataStore.getComparisonTexts(uid);
      final record = <AiRecord>[];
      if (texts.isEmpty) {
        debugPrint("[empty] comparison texts are empty");
        return [];
      }
      for (final text in texts) {
        try {
          // AIRecord 클래스로 변환하기
          // Convert comparison text to AiRecord
          record.add(
            AiRecord(
              key: text.$1,
              isExpanded: false,
              isPinned: text.$2["is_pinned"],
              value: [
                AiText(
                  createdAt: (text.$2["created_at"] as Timestamp).toDate(),
                  text: text.$2["comp_text"],
                ),
              ],
              category:
                  getCategoryEnum[text.$2["category"] as String] ??
                  ProductCategory.liked,
              name: text.$2["prdt_names"],
            ),
          );
        } catch (e) {
          throw Exception("[error] failed to fetch all comparison texts : $e");
        }
      }
      return record;
    } catch (e) {
      throw Exception("[error] failed to fetch all comparison texts : $e");
    }
  }
}
