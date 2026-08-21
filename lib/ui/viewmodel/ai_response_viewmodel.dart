import 'package:finbrain/data/aes_helper.dart';
import 'package:finbrain/data/data_source/user_data_source.dart';
import 'package:finbrain/data/model/entities/ai_record.dart';
import 'package:finbrain/data/model/entities/financial_product.dart';
import 'package:finbrain/data/repository/ai_comp_repository.dart';
import 'package:finbrain/data/repository/ai_response_repository.dart';
import 'package:finbrain/data/repository/ai_summary_repository.dart';
import 'package:finbrain/product_categories.dart';
import 'package:finbrain/ui/viewmodel/ai_comp_tutorial_viewmodel.dart';
import 'package:finbrain/ui/viewmodel/current_page_viewmodel.dart';
import 'package:finbrain/ui/viewmodel/liked_product_viewmodel.dart';
import 'package:finbrain/ui/viewmodel/product_viewmodel.dart';
import 'package:finbrain/data/repository/ai_convo_repository.dart';
import 'package:finbrain/ui/widget/message_bubble.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:finbrain/data/google_auth_service.dart';
part 'ai_response_viewmodel.g.dart';

// AI 응답 관련 레포지토리(AI response repository)
final responseRepository = AiResponseRepository(); 
// AI 대화 내역 관련 레포지토리(AI chat history repository)
final messageRepository = AiConversationRepository();
// AI 대화 요약 내역 관련 레포지토리(AI summary repository) 
final summaryRepository = AiSummaryRepository();
// AI 비교 분석 관련 레포지토리(AI comparison text repository)
final compRepository = AiCompRepository();

// AI 응답 뷰모델
@riverpod
class AiResponseViewmodel extends _$AiResponseViewmodel {
  // 주어진 프롬프트에 대한 응답을 호출
  // Get response about given prompt
  @override
  Future<String?> build(String text, [FinancialProduct? product]) async {
    return await responseRepository.fetchAIResponse(text, product);
  }
}

// AI 어시스트 스크린 뷰모델
// AI assist screen viewmodel
@riverpod
class AiAssistScreenViewmodel extends _$AiAssistScreenViewmodel {
  final userDataSource = UserDataSource();

  @override
  List<String> build(String tag) => [];

  // 상품 코드 및 이름를 통해 상품 불러오기
  // Get product with given product code or name
  Future<FinancialProduct?> getProduct(String tag, ProductCategory ctg) async {
    final page = ref.read(currentPageViewmodelProvider(ctg));
    final productList = await ref.read(
      fetchProductViewmodelProvider(ctg, page).future,
    );
    final likedList = await ref.read(fetchLikedViewmodelProvider.future);
    final product =
        productList.$2
            .where((e) => (e.commonInfo.productName == tag))
            .firstOrNull ??
        likedList.where((e) => e.commonInfo.productName == tag).firstOrNull;
    return product;
  }

  // 프롬프트를 화면에 바로 보이기 위해 로컬에 저장하기
  // Save prompt(request) in local to show in screen directly
  void saveRequest(String newRequest) {
    state = [...state, newRequest];
  }

  // AI 응답 호출하고 요청-응답 서버에 저장하기
  // Fetch AI response about request and save them
  Future<void> fetchResponseAndSaveConv(
    String newRequest,
    String tag,
    ProductCategory ctg,
    String name,
  ) async {
    // 다양한 상황을 다루기 위해 저장
    // Save state to handle multiple situation
    final currentState = state;

    try {
      final product = await getProduct(name, ctg);
      // 상품이 없다면 로컬에 오류 메시지 띄우기
      // if no product found, display error message
      if (product == null) {
        state = [...currentState, "오류가 발생했습니다. 다시 시도해주세요"];
        return;
      }
      // 화면에 로딩 인디케이터를 띄우기 위해 로딩 상태 설정
      // Set loading state to display indicator
      state = [...currentState, "loading"];
      // AI 응답 불러오기
      // Fetch AI response
      final newResponse = await ref.read(
        aiResponseViewmodelProvider(newRequest, product).future,
      );
      
      // 응답이 없다면 에러 메시지 띄우기
      // if response is empty, display error message
      if (newResponse == null || newResponse.isEmpty) {
        state = [...currentState, "오류가 발생했습니다. 다시 시도해주세요"];
        return;
      } else {
        // 응답을 로컬 및 서버에 저장
        // save response in local and server
        state = [...currentState, newResponse];
        await saveConversationInFirestore(
          tag,
          ctg,
          name,
          newRequest,
          newResponse,
        );
        return;
      }
    } catch (e) {
      // 오류 발생 시 에러 메시지 출력
      // Show error message when error occurs
      debugPrint("[error] failed to fetch ai response, $e");
      state = [...currentState, "오류가 발생했습니다. 다시 시도해주세요"];
      return;
    }
  }

  // 상품에 대한 AI 대화 내용 서버에 저장하기
  // Save AI conversation in firestore
  Future<void> saveConversationInFirestore(
    String tag,
    ProductCategory ctg,
    String name,
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
        name,
        request,
        response,
      );
    } catch (e) {
      throw Exception("[error] failed to save request and response : $e");
    }
  }

  // 상품 코드나 이름으로 대화 가져오기
  // Fetch AI conversation about product with its code or name
  Future<List<(MessageBubble, MessageBubble)>> getConversationWithPrdtNmOrCd(
    String tag,
  ) async {
    try {
      final user = GoogleAuthService.getCurrentUser();
      if (user == null) {
        throw Exception("[user] no user found");
      }
      final loaded = await messageRepository.getConversationWithPrdtNmOrCd(
        user.uid,
        tag,
      );
      final conversation = <String, String>{};
      for (final entry in loaded) {
        if (entry["request"] != null && entry["response"] != null) {
          conversation[AesHelper.decryptText(entry["request"]!)] = AesHelper.decryptText(entry["response"]!);
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

  // 상품 코드나 이름으로 AI 대화 요약본 가져오기
  // Get Ai conversation summary with product code or name
  Future<AiRecord> getSummariesWithPrdtNmOrCd(String tag) async {
    try {
      final user = GoogleAuthService.getCurrentUser();
      if (user == null) {
        throw Exception("[user] no user found");
      }

      return await summaryRepository.getSummariesWithPrdtNmOrCd(user.uid, tag);
    } catch (e) {
      throw Exception("[error] failed to fetch summaries : $e");
    }
  }

  // 튜토리얼 관련 함수
  // Functions for product detail tutorial
  Future<bool> readProductDetailTutorial() async {
    final user = GoogleAuthService.getCurrentUser();
    if(user == null || user.displayName == null || user.email == null) return true;
    return userDataSource.readProductDetailTutorial(user);
  }

  Future<void> setReadProductDetailTutorialToTrue() async {
    final user = GoogleAuthService.getCurrentUser();
    if(user == null || user.email == null || user.displayName == null) return;
    return userDataSource.setReadProductDetailTutorialToTrue();
  }
}

// AI 비교 분석 스크린 뷰모델
@riverpod
class AiComparisonScreenViewmodel extends _$AiComparisonScreenViewmodel {
  @override
  Future<String> build(String text) async {
    // 튜토리얼이면 예시 응답 아니면 실제 비교 분석 불러오기
    // Fetch mock response while tutorial, else fetch comparison text
    final isTutorialShown = await ref.read(
        aiCompTutorialViewmodelProvider.future,
      );
    print("isTutorialShown(Viewmodel), $isTutorialShown");
    if(!isTutorialShown){
      print("목데이터 호출");
      return ref.read(aiCompTutorialViewmodelProvider.notifier).getMockRes();
    } else {
      print("실제 응답 호출");
      return _askComparsion(text);
    }
  }

  // AI 비교분석 응답 요청
  // Request comparison among selected products
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

  // 비교 분석 재요청
  // Re-request the comparison
  Future<void> refreshComparison(String text) async {
    state = const AsyncValue.loading();
    try {
      final response = await _askComparsion(text);
      if(ref.mounted){
        state = AsyncValue.data(response);
      }
    } catch (e, st){
      if(ref.mounted){
        state = AsyncValue.error(e, st);
      }
    }
  }

  // 저장소에 비교 글 저장하기
  // Save a single comparison text in firestore
  Future<void> saveComparisonText(
    String names,
    String prdtNamesOrCodes,
    ProductCategory ctg,
  ) async {
    try {
      final user = GoogleAuthService.getCurrentUser();
      if (user == null) {
        throw Exception("[user] no user found");
      } else if (state.value == null) {
        debugPrint(
          "[null] failed to save comparison texts, state.value is null",
        );
        return;
      }

      await compRepository.saveComparisonText(
        user.uid,
        prdtNamesOrCodes,
        state.value!,
        ctg,
        names,
      );
    } catch (e) {
      throw Exception("[error] failed to save comparison texts : $e");
    }
  }
}
