import 'package:finbrain/data/repository/ai_response_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'ai_response_viewmodel.g.dart';

final repository = AiResponseRepository();

@riverpod
class AiResponseViewmodel extends _$AiResponseViewmodel {
  @override
  Future<String?> build(String text) async {
    return await repository.fetchAIResponse(text);
  }
}

@riverpod
class AiScreenViewmodel extends _$AiScreenViewmodel {
  @override
  Map<String, String> build(String tag) => {};

  void addRequest(String newRequest) async {
    final newResponse = await ref.read(
      aiResponseViewmodelProvider(newRequest).future,
    );
    if (newResponse == null || newResponse.isEmpty) {
      final errorResponse = "오류가 발생했습니다. 다시 시도해주세요";
      state = {...state, newRequest: errorResponse};
    } else {
      state = {...state, newRequest: newResponse};
    }
  }
}

@riverpod
class AiComparisonScreenViewmodel extends _$AiComparisonScreenViewmodel {
  @override
  String build(String products) => "";

  void askComparsion(String products) async {
    try {
      print("====================");
      print("Comparison: 비동기 데이터 요청 시작... (인자: $products)");
      final newResponse = await ref.read(
        aiResponseViewmodelProvider(products).future,
      );
      print("Comparison: newResponse - $newResponse");
      if (newResponse == null || newResponse.isEmpty) {
        final errorResponse = "오류가 발생했습니다. 다시 시도해주세요";
        print("Comparison: error - $newResponse");
        state = errorResponse;
      } else {
        state = newResponse;
      }
      print("Comparison: current state - $state");
    } catch (error) {
      print("Comparsion: error - $error");
    } finally{
      print("====================");
    }
  }
}
