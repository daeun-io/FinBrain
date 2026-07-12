import 'package:finbrain/data/model/entities/ai_record.dart';
import 'package:finbrain/data/model/entities/financial_product.dart';
import 'package:finbrain/data/repository/ai_comp_repository.dart';
import 'package:finbrain/data/repository/ai_response_repository.dart';
import 'package:finbrain/data/repository/ai_summary_repository.dart';
import 'package:finbrain/product_categories.dart';
import 'package:finbrain/ui/viewModel/current_page_viewmodel.dart';
import 'package:finbrain/ui/viewModel/liked_product_viewmodel.dart';
import 'package:finbrain/ui/viewModel/product_viewmodel.dart';
import 'package:finbrain/data/repository/ai_convo_repository.dart';
import 'package:finbrain/ui/widget/message_bubble.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:finbrain/data/google_auth_service.dart';
part 'ai_response_viewmodel.g.dart';

final responseRepository = AiResponseRepository();
final messageRepository = AiConversationRepository();
final summaryRepository = AiSummaryRepository();
final compRepository = AiCompRepository();

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
  List<String> build(String tag) => [];

  Future<FinancialProduct?> getProduct(String tag, ProductCategory ctg) async {
    final page = ref.read(currentPageViewmodelProvider(ctg));
    final productList = await ref.read(
      fetchProductViewmodelProvider(ctg, "$page").future,
    );
    final likedList = await ref.read(fetchLikedViewmodelProvider.future);
    final product =
        productList.$2
            .where((e) => (e.commonInfo.productName == tag))
            .firstOrNull ??
        likedList.where((e) => e.commonInfo.productName == tag).firstOrNull;
    if (product == null) print("product $product");
    return product;
  }

  void saveRequest(String newRequest){
    state = [...state, newRequest];
  }

  Future<void> fetchResponseAndSaveConv(
    String newRequest,
    String tag,
    ProductCategory ctg,
  ) async {
    try {
      print("======================");
      print("tag: $tag");

      final product = await getProduct(tag, ctg);
      if (product == null) {
        state = [...state, "오류가 발생했습니다. 다시 시도해주세요"];
        return;
      }

      final newResponse = await ref.read(
        aiResponseViewmodelProvider(newRequest, product).future,
      );
      print("ai response: $newResponse");

      if (newResponse == null || newResponse.isEmpty) {
        state = [...state, "오류가 발생했습니다. 다시 시도해주세요"];
        return;
      } else {
        state = [...state, newResponse];
        await saveConversationInFirestore(tag, ctg, newRequest, newResponse);
        print("====================");
        return;
      }
    } catch (error) {
      print("Error fetching AI response: $error");
      state = [...state, "오류가 발생했습니다. 다시 시도해주세요"];
      return;
    }
  }

  Future<void> saveConversationInFirestore(
    String tag,
    ProductCategory ctg,
    String request,
    String response,
  ) async {
    try {
      final user = GoogleAuthService.getCurrentUser();
      if (user == null) {
        print("No user is currently signed in.");
        return;
      }
      await messageRepository.saveRequestAndResponse(
        user.uid,
        tag,
        ctg.toString(),
        request,
        response,
      );
    } catch (error) {
      print("Error saving conversation in Firestore: $error");
    }
  }

  Future<List<(MessageBubble, MessageBubble)>> getConversationWithPrdtNm(
    String tag,
  ) async {
    try {
      final user = GoogleAuthService.getCurrentUser();
      if (user == null) {
        print("No user is currently signed in.");
        return [];
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
      final messages = conversation.entries.map(
        (e) => (
          MessageBubble(isUser: true, text: e.key),
          MessageBubble(isUser: false, text: e.value),
        ),
      ).toList();
      return messages;
    } catch (error) {
      print("Error getting conversation: $error");
      return [];
    }
  }

  Future<AiRecord> getSummariesWithPrdtNm(String tag) async {
    try {
      final user = GoogleAuthService.getCurrentUser();
      if (user == null) {
        print("No user is currently signed in.");
        return AiRecord(
          key: "",
          isExpanded: false,
          isPinned: false,
          value: [],
          category: ProductCategory.liked,
        );
      }

      return await summaryRepository.getSummariesWithPrdtNm(user.uid, tag);
    } catch (e) {
      print("Error getting summaries: $e");
      return AiRecord(
        key: "",
        isExpanded: false,
        isPinned: false,
        value: [],
        category: ProductCategory.liked,
      );
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

  Future<void> saveComparisonText(ProductCategory ctg) async {
    try {
      final user = GoogleAuthService.getCurrentUser();
      if (user == null) {
        print("No current user found");
        return;
      }
      await compRepository.saveComparisonText(user.uid, products, state, ctg);
    } catch (e) {
      print("Error saving comparison text");
    }
  }
}
