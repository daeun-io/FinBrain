class AiRecord {
  final String key;
  final List<AiText> value;
  bool isExpanded;
  bool isPinned;

  AiRecord({
    required this.key,
    required this.isExpanded,
    required this.isPinned,
    required this.value,
  });

}

class AiText {
  final DateTime createdAt;
  final String text;

  const AiText({
    required this.createdAt,
    required this.text,
  });
}