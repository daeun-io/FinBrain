import 'package:finbrain/data/data_sources/ai_convo_data_source.dart';

class AiConversationRepository {
  final dataSource = AiConversationDataSource();

  Future<bool> checkCollectionExistsAndCreate(
    String uid,
    String productName,
  ) async {
    try {
      final exists = await dataSource.isMessagesCollectionExists(
        uid,
        productName,
      );
      if (!exists) {
        await dataSource.createMessagesCollection(uid, productName);
      }
      return exists;
    } catch (e) {
      print("Error checking and creating messages collection: $e");
      return false;
    }
  }

  Future<void> saveRequestAndResponse(
    String uid,
    String productName,
    String request,
    String response,
  ) async {
    try {
      await dataSource.saveRequestAndResponse(
        uid,
        productName,
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
