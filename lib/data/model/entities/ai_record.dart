import 'package:finbrain/product_categories.dart';

// AI 요약 및 비교 기록
// AI summary and comparison records
class AiRecord {
  final String key;
  final List<AiText> value;
  final ProductCategory category;
  final String name;
  bool isExpanded;
  bool isPinned;
  
  AiRecord({
    required this.key,
    required this.isExpanded,
    required this.isPinned,
    required this.value,
    required this.category,
    required this.name,
  });

  AiRecord copyWith([bool? expanded, bool? pinned]) {
    return AiRecord(
      key: key,
      isExpanded: expanded ?? isExpanded,
      isPinned: pinned ?? isPinned,
      value: value,
      category: category,
      name: name,
    );
  }
}

// 실제 AI 답변
// Actual AI response
class AiText {
  final DateTime createdAt;
  final String text;

  const AiText({required this.createdAt, required this.text});
}
