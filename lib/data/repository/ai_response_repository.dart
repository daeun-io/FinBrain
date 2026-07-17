import 'package:finbrain/data/model/entities/financial_product.dart';
import 'package:firebase_ai/firebase_ai.dart';

class AiResponseRepository {
  Future<String?> fetchAIResponse(
    String text, [
    FinancialProduct? product,
  ]) async {
    final model = FirebaseAI.googleAI().generativeModel(
      model: "gemini-3.5-flash",
    );

    final prompt = [Content.text(text)];
    if (product != null) {
      prompt.add(
        Content.text(
          """현재 사용자가 묻는 상품은 ${product.commonInfo.companyName}의 ${product.commonInfo.productName}이야.
          어려운 금융 용어를 쉽고 직관적으로 설명하고 상품 정보에 명시되지 않은 내용은 임의로 지어내지 마.
          또한 공식 웹사이트에서 정보를 가져올 경우, 출처를 함께 표시해.""",
        ),
      );
    }
    try {
      final response = await model.generateContent(prompt);
      return response.text;
    } catch (e) {
      throw Exception("[error] failed to ai response) : $e");

    }
  }
}
