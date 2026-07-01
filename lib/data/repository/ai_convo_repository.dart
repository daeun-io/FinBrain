import 'package:finbrain/data/data_sources/ai_convo_data_source.dart';
import 'package:finbrain/data/google_auth_service.dart';

class AiConversationRepository {
  final dataSource = AiConversationDataSource();

  Future<void> checkCollectionExistsAndCreate(String productName) async {
    try {
      final user = GoogleAuthService.getCurrentUser();
      if (user == null) {
        print("No user is currently signed in.");
        return;
      }
      final exists = await dataSource.isMessagesCollectionExists(
        user.uid,
        productName,
      );
      if (!exists) {
        await dataSource.createMessagesCollection(user.uid, productName);
      }
    } catch (e) {
      print("Error checking and creating messages collection: $e");
    }
  }

  Future<void> updateRequestAndResponse(
    String productName,
    Map<String, String> messages,
  ) async {
    try {
      final user = GoogleAuthService.getCurrentUser();
      if (user == null) {
        print("No user is currently signed in.");
        return;
      }
      await dataSource.updateRequestAndResponse(user.uid, productName, messages);
    } catch (e) {
      print("Error updating request and response: $e");
    }
  }
}
