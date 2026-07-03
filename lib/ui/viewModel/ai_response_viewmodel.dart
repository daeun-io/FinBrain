import 'package:finbrain/data/model/entities/ai_record.dart';
import 'package:finbrain/data/model/entities/financial_product.dart';
import 'package:finbrain/data/repository/ai_response_repository.dart';
import 'package:finbrain/data/repository/ai_summary_repository.dart';
import 'package:finbrain/ui/viewmodel/product_viewmodel.dart';
import 'package:finbrain/data/repository/ai_convo_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:finbrain/data/google_auth_service.dart';
part 'ai_response_viewmodel.g.dart';

final responseRepository = AiResponseRepository();
final messageRepository = AiConversationRepository();
final summaryRepository = AiSummaryRepository();

@riverpod
class AiResponseViewmodel extends _$AiResponseViewmodel {
  @override
  Future<String?> build(String text, [FinancialProduct? product]) async {
    return await responseRepository.fetchAIResponse(text, product);
  }
}

@riverpod
class AiScreenViewmodel extends _$AiScreenViewmodel {
  @override
  Map<String, String> build(String tag) => {};

  Future<FinancialProduct?> getProduct(String tag) async {
    final productList = await ref.read(productViewmodelProvider.future);
    final product = productList.$2
        .where((e) => (e.commonInfo.productName == tag))
        .firstOrNull;
    print("product $product");
    return product;
  }

  Future<void> fetchRequestAndSaveConv(String newRequest, String tag) async {
    try {
      print("======================");
      print("tag: $tag");

      final product = await getProduct(tag);
      if (product == null) {
        state = {...state, newRequest: "오류가 발생했습니다. 다시 시도해주세요"};
        return;
      }

      final newResponse = await ref.read(
        aiResponseViewmodelProvider(newRequest, product).future,
      );
      print("ai response: $newResponse");

      if (newResponse == null || newResponse.isEmpty) {
        state = {...state, newRequest: "오류가 발생했습니다. 다시 시도해주세요"};
        return;
      } else {
        state = {...state, newRequest: newResponse};
        await saveConversationInFirestore(tag, newRequest, newResponse);
        print("====================");
        return;
      }
    } catch (error) {
      print("Error fetching AI response: $error");
      state = {...state, newRequest: "오류가 발생했습니다. 다시 시도해주세요"};
      return;
    }
  }

  Future<bool> checkCollectionExistsAndCreate(String tag) async {
    try {
      final user = GoogleAuthService.getCurrentUser();
      if (user == null) {
        print("No user is currently signed in.");
        return false;
      }
      return await messageRepository.checkCollectionExistsAndCreate(
        user.uid,
        tag,
      );
    } catch (error) {
      print("Error checking collection existence: $error");
      return false;
    }
  }

  Future<void> saveConversationInFirestore(String tag, String request, String response) async {
    try {
      final user = GoogleAuthService.getCurrentUser();
      if (user == null) {
        print("No user is currently signed in.");
        return;
      }
      await messageRepository.saveRequestAndResponse(user.uid, tag, request, response);
    } catch (error) {
      print("Error saving conversation in Firestore: $error");
    }
  }

  Future<void> getConversationWithPrdtNm(String tag) async {
    try {
      final user = GoogleAuthService.getCurrentUser();
      if (user == null) {
        print("No user is currently signed in.");
        return;
      }
      final loaded = await messageRepository.getConversationWithPrdtNm(
        user.uid,
        tag,
      );
      final conversation = <String, String>{};
      for (final entry in loaded) {
        if (entry["request"] != null && entry["response"] != null) {
          conversation[entry["request"]!] = entry["response"]!;
        }
      }
      state = conversation;
    } catch (error) {
      print("Error getting conversation: $error");
    }
  }

  Future<AiRecord> getSummariesWithPrdtNm(String tag) async {
    try {
      final user = GoogleAuthService.getCurrentUser();
      if(user == null){
        print("No user is currently signed in.");
        return AiRecord(key: "", isExpanded: false, isPinned: false, value: []);
      }

      return await summaryRepository.getSummariesWithPrdtNm(user.uid, tag);
    } catch (e) {
      print("Error getting summaries: $e");
      return AiRecord(key: "", isExpanded: false, isPinned: false, value: []);
    }
  }
}

@riverpod
class AiComparisonScreenViewmodel extends _$AiComparisonScreenViewmodel {
  @override
  String build(String products) => "";

  void askComparsion(String products) async {
    try {
      final newResponse = await ref.read(
        aiResponseViewmodelProvider(products).future,
      );
      if (newResponse == null || newResponse.isEmpty) {
        state = "오류가 발생했습니다. 다시 시도해주세요";
      } else {
        state = newResponse;
      }
    } catch (error) {
      print("Ai Comparsion: error - $error");
    }
  }
}
