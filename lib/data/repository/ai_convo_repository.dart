import 'package:finbrain/data/data_source/ai_convo_data_source.dart';

class AiConversationRepository {
  final dataSource = AiConversationDataSource();

  // 상품에 대한 AI 대화 내용 서버에 저장하기
  // Save AI conversation in firestore
  Future<void> saveRequestAndResponse(
    String uid,
    String productNameOrCode,
    String ctg,
    String productName,
    String request,
    String response,
  ) async {
    try {
      await dataSource.saveRequestAndResponse(
        uid,
        productNameOrCode,
        ctg,
        productName,
        request,
        response,
      );
    } catch (e) {
      throw Exception("[error] failed to save request and response : $e");
    }
  }

  // 상품 코드나 이름으로 대화 가져오기
  // Fetch AI conversation about product with its code or name
  Future<List<Map<String, String>>> getConversationWithPrdtNmOrCd(
    String uid,
    String productNameOrCode,
  ) async {
    try {
      final conversation = await dataSource.getConversationWithPrdtNmOrCd(
        uid,
        productNameOrCode,
      );

      final casted = conversation
          .map(
            (doc) => doc.map((key, value) => MapEntry(key, value.toString())),
          )
          .toList();
      return casted;
    } catch (e) {
      throw Exception("[error] failed to fetch messages(chat_history) : $e");
    }
  }
}