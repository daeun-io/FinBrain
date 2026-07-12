import 'package:finbrain/data/data_source/ai_convo_data_source.dart';

class AiConversationRepository {
  final dataSource = AiConversationDataSource();

  Future<void> saveRequestAndResponse(
    String uid,
    String productName,
    String ctg,
    String request,
    String response,
  ) async {
    try {
      await dataSource.saveRequestAndResponse(
        uid,
        productName,
        ctg,
        request,
        response,
      );
    } catch (e) {
      print("Error saving request and response: $e");
    }
  }

  Future<List<Map<String, String>>> getConversationWithPrdtNm(
    String uid,
    String productName,
  ) async {
    try {
      final conversation = await dataSource.getConversationWithPrdtNm(
        uid,
        productName,
      );

      final casted = conversation
          .map(
            (doc) => doc.map((key, value) => MapEntry(key, value.toString())),
          )
          .toList();
      return casted;
    } catch (e) {
      print("Error getting conversation: $e");
      return [];
    }
  }
}