class CreateOrderConversationResponse {
  String id;
  String orderConversationId;
  String message;
  String userId;

  CreateOrderConversationResponse({
    required this.id,
    required this.orderConversationId,
    required this.message,
    required this.userId
  });
}