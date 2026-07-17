import 'package:finbrain/data/model/entities/ai_record.dart';
import 'package:finbrain/data/model/entities/financial_product.dart';
import 'package:finbrain/data/repository/ai_comp_repository.dart';
import 'package:finbrain/data/repository/ai_response_repository.dart';
import 'package:finbrain/data/repository/ai_summary_repository.dart';
import 'package:finbrain/product_categories.dart';
import 'package:finbrain/ui/viewmodel/current_page_viewmodel.dart';
import 'package:finbrain/ui/viewmodel/liked_product_viewmodel.dart';
import 'package:finbrain/ui/viewmodel/product_viewmodel.dart';
import 'package:finbrain/data/repository/ai_convo_repository.dart';
import 'package:finbrain/ui/widget/message_bubble.dart';
import 'package:flutter/foundation.dart';
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
class AiAssistScreenViewmodel extends _$AiAssistScreenViewmodel {
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
    return product;
  }

  void saveRequest(String newRequest) {
    state = [...state, newRequest];
  }

  Future<void> fetchResponseAndSaveConv(
    String newRequest,
    String tag,
    ProductCategory ctg,
  ) async {
    final currentState = state;

    try {
      final product = await getProduct(tag, ctg);
      if (product == null) {
        state = [...currentState, "오류가 발생했습니다. 다시 시도해주세요"];
        return;
      }
      state = [...currentState, "loading"];

      final newResponse = await ref.read(
        aiResponseViewmodelProvider(newRequest, product).future,
      );

      if (newResponse == null || newResponse.isEmpty) {
        state = [...currentState, "오류가 발생했습니다. 다시 시도해주세요"];
        return;
      } else {
        state = [...currentState, newResponse];
        await saveConversationInFirestore(tag, ctg, newRequest, newResponse);
        return;
      }
    } catch (e) {
      debugPrint("[error] failed to fetch ai response, $e");
      state = [...currentState, "오류가 발생했습니다. 다시 시도해주세요"];
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
        throw Exception("[user] no user found");
      }
      await messageRepository.saveRequestAndResponse(
        user.uid,
        tag,
        ctg.toString(),
        request,
        response,
      );
    } catch (e) {
      throw Exception("[error] failed to save request and response : $e");
    }
  }

  Future<List<(MessageBubble, MessageBubble)>> getConversationWithPrdtNm(
    String tag,
  ) async {
    try {
      final user = GoogleAuthService.getCurrentUser();
      if (user == null) {
        throw Exception("[user] no user found");
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
      final messages = conversation.entries
          .map(
            (e) => (
              MessageBubble(isUser: true, text: e.key),
              MessageBubble(isUser: false, text: e.value),
            ),
          )
          .toList();
      return messages;
    } catch (e) {
      throw Exception("[error] failed to fetch messages(chat_history) : $e");
    }
  }

  Future<AiRecord> getSummariesWithPrdtNm(String tag) async {
    try {
      final user = GoogleAuthService.getCurrentUser();
      if (user == null) {
        throw Exception("[user] no user found");
      }

      return await summaryRepository.getSummariesWithPrdtNm(user.uid, tag);
    } catch (e) {
      throw Exception("[error] failed to fetch summaries : $e");
    }
  }
}

@riverpod
class AiComparisonScreenViewmodel extends _$AiComparisonScreenViewmodel {
  @override
  Future<String> build(String text) async {
    return _askComparsion(text);
  }

  Future<String> _askComparsion(String text) async {
    try {
      final newResponse = await ref.read(
        aiResponseViewmodelProvider(text).future,
      );
      if (newResponse == null || newResponse.isEmpty) {
        return "오류가 발생했습니다. 다시 시도해주세요";
      }
      return newResponse;
    } catch (e) {
      debugPrint("[error] failed to fetch ai comparison, $e");
      return "오류가 발생했습니다. 다시 시도해주세요";
    }
  }

  Future<void> refreshComparison(String text) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _askComparsion(text));
  }

  Future<void> saveComparisonText(ProductCategory ctg) async {
    try {
      final user = GoogleAuthService.getCurrentUser();
      if (user == null) {
        throw Exception("[user] no user found");
      }

      state.whenData(
        (data) async =>
            await compRepository.saveComparisonText(user.uid, text, data, ctg),
      );
      
    } catch (e) {
      throw Exception("[error] failed to fetch all comparison texts : $e");
    }
  }
}
