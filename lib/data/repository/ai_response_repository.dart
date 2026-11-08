import 'package:finbrain/data/data_source/user_data_source.dart';
import 'package:finbrain/data/model/entities/financial_product.dart';
import 'package:firebase_ai/firebase_ai.dart';

// AI 응답 레포지토리
// AI response repository
class AiResponseRepository {
  final userDataSource = UserDataSource();

  // AI 응답 호출하기
  // Get AI response with given request
  Future<String?> fetchAIResponse(
    String text, [
    FinancialProduct? product,
  ]) async {
    // AI 모델: 제미나이
    // AI Model: Gemini
    final model = FirebaseAI.googleAI().generativeModel(
      model: "gemini-3.5-flash-lite",
    );

    // 프롬프트 지정
    // Set AI prompt
    final prompt = <Content>[];
    final tone = await userDataSource.getAiTone();
    if (product != null && tone != null) {
      final tPrompt = switch (tone) {
        "설명적으로" => "차근차근 설명해주세요. 복잡한 내용도 쉽게 이해하도록 예시를 들어가며 단계별로 풀어서 설명해주세요.",
        "간결하게" => "핵심만 간단하게, 불필요한 설명을 제외하고 중요한 내용만 짧고 명확하게 설명해주세요",
        "전문적으로" => "해당 분야의 정확한 용어를 사용하고, 구체적인 데이터나 절차를 포함해 전문적으로 설명해주세요",
        _ => tone,
      };
      prompt.add(
        Content.text(
          "${product.commonInfo.companyName}의 ${product.commonInfo.productName}에 대해 $text한 질문의 답을 $tPrompt",
        ),
      );
    }

    // 응답 생성하기
    // Get AI response
    try {
      final response = await model.generateContent(prompt);
      return response.text;
    } catch (e) {
      throw Exception("[error] failed to ai response) : $e");
    }
  }
}
