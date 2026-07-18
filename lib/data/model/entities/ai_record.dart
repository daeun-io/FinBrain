import 'package:finbrain/product_categories.dart';

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

class AiText {
  final DateTime createdAt;
  final String text;

  const AiText({required this.createdAt, required this.text});
}
