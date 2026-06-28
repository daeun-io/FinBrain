import 'package:firebase_ai/firebase_ai.dart';

class AiResponseRepository {
  Future<String?> fetchAIResponse(String text) async {
    final model = FirebaseAI.googleAI().generativeModel(
      model: "gemini-3.5-flash",
    );

    final prompt = [Content.text(text)];
    try {
      final response = await model.generateContent(prompt);
      return response.text;
    } catch (error) {
      print("error: Error occurred while calling ai response, $error");
      return null;
    }
  }
}