class AiRecord {
  final String key;
  final List<AiText> text;
  bool isExpanded;
  bool isPinned;

  AiRecord({
    required this.key,
    required this.isExpanded,
    required this.isPinned,
    required this.text,
  });

}

class AiText {
  final DateTime createdAt;
  final String summary;

  const AiText({
    required this.createdAt,
    required this.summary,
  });
}