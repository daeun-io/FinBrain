import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finbrain/data/converter.dart';
import 'package:finbrain/data/data_source/ai_comp_data_source.dart';
import 'package:finbrain/data/model/entities/ai_record.dart';
import 'package:finbrain/product_categories.dart';

class AiCompRepository {
  final dataStore = AiCompDataSource();

  Future<void> saveComparisonText(
    String uid,
    String products,
    String text,
    ProductCategory ctg,
  ) async {
    try {
      await dataStore.saveComparisonText(uid, products, text, ctg);
    } catch (e) {
      print("Error saving comparison text, $e");
    }
  }

  Future<List<AiRecord>> getComparisonTexts(String uid) async {
    try {
      final texts = await dataStore.getComparisonTexts(uid);
      final record = <AiRecord>[];
      if (texts.isEmpty) {
        print("comparison texts are empty");
        return [];
      }
      for (final text in texts) {
        try {
          record.add(
            AiRecord(
              key: text.$1,
              isExpanded: false,
              isPinned: false,
              value: [
                AiText(
                  createdAt: (text.$2["created_at"] as Timestamp).toDate(),
                  text: text.$2["comp_text"],
                ),
              ],
              category: getCategoryEnum[text.$2["category"] as String]
            ),
          );
        } catch (e) {
          print("Error mapping summaries: $e");
          return [];
        }
      }
      return record;
    } catch (e) {
      print("error occurred while fethcing comparison text");
      return <AiRecord>[];
    }
  }
}
