import 'package:finbrain/data/data_source/ai_convo_data_source.dart';
import 'package:finbrain/data/model/entities/ai_record.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AiSummaryRepository {
  final dataSource = AiConversationDataSource();

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
      );
      return record;
    } catch (e) {
      print("Error mapping conversation: $e");
      return AiRecord(
        key: "null",
        isExpanded: false,
        isPinned: false,
        value: [],
      );
    }
  }
}

