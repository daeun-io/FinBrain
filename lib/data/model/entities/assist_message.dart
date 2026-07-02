class AssistMessage {
  final String request;
  final String response;
  final DateTime createdAt;
  final String productName;

  AssistMessage({
    required this.request,
    required this.response,
    required this.productName
  }): createdAt = DateTime.now();
}
