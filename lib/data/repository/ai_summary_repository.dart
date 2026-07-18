import 'package:finbrain/data/converter.dart';
import 'package:finbrain/data/data_source/ai_summary_data_source.dart';
import 'package:finbrain/data/model/entities/ai_record.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finbrain/product_categories.dart';
import 'package:flutter/cupertino.dart';

class AiSummaryRepository {
  final dataSource = AiSummaryDataSource();

  Future<void> updateSummaries(
    String uid,
    String productNameOrCd,
    List<AiText> texts,
    ProductCategory ctg,
    String productName,
    bool isPinned,
  ) async {
    try {
      final aiTextAsMap = texts
          .map((e) => {"created_at": e.createdAt, "summary": e.text})
          .toList();
      await dataSource.updateSummaries(
        uid,
        productNameOrCd,
        aiTextAsMap,
        ctg.toString(),
        productName,
        isPinned,
      );
    } catch (e) {
      throw Exception("[error] failed to update summaries : $e");
    }
  }

  Future<AiRecord> getSummariesWithPrdtNmOrCd(
    String uid,
    String productNameOrCd,
  ) async {
    try {
      final summary = await dataSource.getSummariesWithPrdtNmOrCd(uid, productNameOrCd);
      if (summary.isEmpty) {
        debugPrint("[empty] $productNameOrCd summary list is empty");
        return AiRecord(
          key: "",
          isExpanded: false,
          isPinned: false,
          value: [],
          category: ProductCategory.liked,
          name: "",
        );
      }
      final record = AiRecord(
        key: productNameOrCd, // change later
        isExpanded: false,
        isPinned: summary["is_pinned"],
        value: (summary["summaries"] as List)
            .map<AiText>(
              (e) => AiText(
                createdAt: (e["created_at"] as Timestamp).toDate(),
                text: e["summary"],
              ),
            )
            .toList(),
        category: getCategoryEnum[summary["category"]] ?? ProductCategory.liked,
        name: summary["prdt_name"]
      );
      return record;
    } catch (e) {
      throw Exception("[error] failed to fetch $productNameOrCd summaries : $e");
    }
  }

  Future<List<AiRecord>> getAllSummaries(String uid) async {
    try {
      final summaries = await dataSource.getAllSummaries(uid);
      final record = <AiRecord>[];

      if (summaries.isEmpty) {
        debugPrint("[empty] summaries are empty");
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
              name: summary.$2["prdt_name"],
            ),
          );
        } catch (e) {
          throw Exception("[error] failed to map summary to AiRecord : $e");
        }
      }
      return record;
    } catch (e) {
      throw Exception("[error] failed to fetch all summaries : $e");
    }
  }
}
