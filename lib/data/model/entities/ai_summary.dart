class AiSummary {
  final String productName;
  final List<ChatSummary> chatSummaries;
  bool isExpanded;

  AiSummary({
    required this.productName,
    required this.isExpanded,
    required this.chatSummaries,
  });

}

class ChatSummary {
  final DateTime createdAt;
  final String summary;

  const ChatSummary({
    required this.createdAt,
    required this.summary,
  });
}