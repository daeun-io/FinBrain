import 'package:finbrain/data/models/entities/financial_product.dart';
import 'package:finbrain/data/repository/ai_response_repository.dart';
import 'package:finbrain/data/viewModel/product_viewmodel.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'ai_response_viewmodel.g.dart';

final repository = AiResponseRepository();

@riverpod
class AiResponseViewmodel extends _$AiResponseViewmodel {
  @override
  Future<String?> build(String text, [FinancialProduct? product]) async {
    return await repository.fetchAIResponse(text, product);
  }
}

@riverpod
class AiScreenViewmodel extends _$AiScreenViewmodel {
  @override
  Map<String, String> build(String tag) => {};

  void addRequest(String newRequest, String tag) async {
    print("======================");
    print("tag: $tag");
    final productList = await ref.read(productViewmodelProvider.future);
    final product =
        productList.$2
            .where((e) => (e.commonInfo.productName == tag))
            .firstOrNull;
    print("product $product");
    if(product == null){
      state = {...state, newRequest: "오류가 발생했습니다. 다시 시도해주세요"};
      return;
    }
    
    final newResponse = await ref.read(
      aiResponseViewmodelProvider(newRequest, product).future,
    );
    print("ai response: $newResponse");
    if (newResponse == null || newResponse.isEmpty) {
      state = {...state, newRequest: "오류가 발생했습니다. 다시 시도해주세요"};
    } else {
      state = {...state, newRequest: newResponse};
    }
    print("====================");
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
