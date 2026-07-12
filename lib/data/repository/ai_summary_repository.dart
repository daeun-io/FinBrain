import 'package:finbrain/data/converter.dart';
import 'package:finbrain/data/data_source/ai_summary_data_source.dart';
import 'package:finbrain/data/model/entities/ai_record.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finbrain/product_categories.dart';

class AiSummaryRepository {
  final dataSource = AiSummaryDataSource();

  Future<void> updateSummaries(
    String uid,
    String productName,
    List<AiText> texts,
    ProductCategory ctg,
    bool isPinned,
  ) async {
    try {
      final aiTextAsMap = texts.map((e) => {
        "created_at": e.createdAt,
        "summary": e.text
      }).toList();
      await dataSource.updateSummaries(uid, productName, aiTextAsMap, ctg.toString(), isPinned);
    } catch (e) {
      print("Error in updating summaries, $e");
    }
  }

  Future<AiRecord> getSummariesWithPrdtNm(
    String uid,
    String productName,
  ) async {
    try {
      final summary = await dataSource.getSummariesWithPrdtNm(uid, productName);

      final record = AiRecord(
        key: productName,
        isExpanded: false,
        isPinned: false,
        value: (summary["summaries"] as List)
            .map<AiText>(
              (e) => AiText(
                createdAt: (e["created_at"] as Timestamp).toDate(),
                text: e["summary"],
              ),
            )
            .toList(),
        category: getCategoryEnum[summary["category"]] ?? ProductCategory.liked,
      );
      return record;
    } catch (e) {
      print("Error in mapping summaries: $e");
      return AiRecord(
        key: "null",
        isExpanded: false,
        isPinned: false,
        value: [],
        category: ProductCategory.liked,
      );
    }
  }

  Future<List<AiRecord>> getAllSummaries(String uid) async {
    try {
      final summaries = await dataSource.getAllSummaries(uid);
      final record = <AiRecord>[];

      if (summaries.isEmpty) {
        print("summaries are empty");
        return [];
      }

      for (final summary in summaries) {
        try {
          record.add(
            AiRecord(
              key: summary.$1,
              isExpanded: false,
              isPinned: summary.$2["is_pinned"],
              value: (summary.$2["summaries"] as List)
                  .map<AiText>(
                    (e) => AiText(
                      createdAt: (e["created_at"] as Timestamp).toDate(),
                      text: e["summary"],
                    ),
                  )
                  .toList(),
              category:
                  getCategoryEnum[summary.$2["category"]] ??
                  ProductCategory.liked,
            ),
          );
        } catch (e) {
          print("Error mapping summaries: $e");
          return [];
        }
      }
      return record;
    } catch (error) {
      print("Error mapping summaries: $error");
      return [];
    }
  }
}
