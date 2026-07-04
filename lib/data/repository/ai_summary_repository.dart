import 'package:finbrain/data/data_source/ai_summary_data_source.dart';
import 'package:finbrain/data/model/entities/ai_record.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AiSummaryRepository {
  final dataSource = AiSummaryDataSource();

  Future<AiRecord> getSummariesWithPrdtNm(
    String uid,
    String productName,
  ) async {
    try {
      final summaries = await dataSource.getSummariesWithPrdtNm(
        uid,
        productName,
      );

      final record = AiRecord(
        key: productName,
        isExpanded: false,
        isPinned: false,
        value: summaries
            .map(
              (e) => AiText(
                createdAt: (e["createdAt"] as Timestamp).toDate(),
                text: e["summary"],
              ),
            )
            .toList(),
        category: null
      );
      return record;
    } catch (e) {
      print("Error mapping conversation: $e");
      return AiRecord(
        key: "null",
        isExpanded: false,
        isPinned: false,
        value: [],
        category: null
      );
    }
  }

  Future<List<AiRecord>> getAllSummaries(String uid) async {
    try {
      final summaries = await dataSource.getAllSummaries(uid);
      final record = <AiRecord>[];

      if(summaries.isEmpty){
        print("summaries are empty");
        return [];
      }

      for (final summary in summaries) {
        try {
          record.add(
            AiRecord(
              key: summary.$1,
              isExpanded: false,
              isPinned: false,
              value: summary.$2
                  .map(
                    (e) => AiText(
                      createdAt: (e["createdAt"] as Timestamp).toDate(),
                      text: e["summary"],
                    ),
                  )
                  .toList(),
              category: null
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
