import 'package:finbrain/data/aes_helper.dart';
import 'package:finbrain/data/converter.dart';
import 'package:finbrain/data/data_source/ai_summary_data_source.dart';
import 'package:finbrain/data/model/entities/ai_record.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finbrain/product_categories.dart';
import 'package:flutter/cupertino.dart';

class AiSummaryRepository {
  final dataSource = AiSummaryDataSource();

  // AI 대화 내용 고정 여부 업데이트
  // Update whether summary is pinned or not
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

  // 상품 코드나 이름으로 AI 대화 요약본 가져오기
  // Get Ai conversation summary with product code or name
  Future<AiRecord> getSummariesWithPrdtNmOrCd(
    String uid,
    String productNameOrCd,
  ) async {
    try {
      final summary = await dataSource.getSummariesWithPrdtNmOrCd(uid, productNameOrCd);
      if (summary.isEmpty) {
        debugPrint("[empty] $productNameOrCd summary list is empty");
        // 빈 AiRecord 반환
        // Return an empty AiRecord
        return AiRecord(
          key: "",
          isExpanded: false,
          isPinned: false,
          value: [],
          // liked는 필터링에 안 쓰이기에 지정
          // ProductCategory.liked is not used in filtering AiRecords
          category: ProductCategory.liked,
          name: "",
        );
      }
      // 요약본 AiRecord로 변환
      // Convert summaries to AiRecord
      final record = AiRecord(
        key: productNameOrCd,
        isExpanded: false,
        isPinned: summary["is_pinned"],
        value: (summary["summaries"] as List)
            .map<AiText>(
              (e) => AiText(
                createdAt: (e["created_at"] as Timestamp).toDate(),
                text: AesHelper.decryptText(e["summary"]),
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

  // 모든 AI 대화 요약 가져오기
  // Get all AI conversation summaries
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
          // 요약본 AiRecord로 변환 후 리스트에 저장
          // Convert summaries to AiRecord and add to list
          record.add(
            AiRecord(
              key: summary.$1,
              isExpanded: false,
              isPinned: summary.$2["is_pinned"],
              value: (summary.$2["summaries"] as List)
                  .map<AiText>(
                    (e) => AiText(
                      createdAt: (e["created_at"] as Timestamp).toDate(),
                      text: AesHelper.decryptText(e["summary"]),
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
