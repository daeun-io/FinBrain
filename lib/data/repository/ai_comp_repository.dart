import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finbrain/data/converter.dart';
import 'package:finbrain/data/data_source/ai_comp_data_source.dart';
import 'package:finbrain/data/model/entities/ai_record.dart';
import 'package:finbrain/product_categories.dart';
import 'package:flutter/widgets.dart';

class AiCompRepository {
  final dataStore = AiCompDataSource();

  Future<void> saveComparisonText(
    String uid,
    String products,
    String text,
    ProductCategory ctg, [
    bool? isPinned,
  ]) async {
    try {
      await dataStore.saveComparisonText(uid, products, text, ctg, isPinned);
    } catch (e) {
      throw Exception("[error] failed to save comparison text : $e");
    }
  }

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
