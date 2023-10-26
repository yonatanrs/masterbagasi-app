import '../user_chat.dart';
import '../user_message.dart';

class OrderMessage extends UserMessage {
  OrderMessage({
    required String id,
    required String orderConversationId,
    required String userId,
    required String message,
    required int readStatus,
    required DateTime? createdAt,
    required DateTime? updatedAt,
    required DateTime? deletedAt,
    required UserChat userChat
  }) : super(
    id: id,
    conversationId: orderConversationId,
    userId: userId,
    message: message,
    readStatus: readStatus,
    createdAt: createdAt,
    updatedAt: updatedAt,
    deletedAt: deletedAt,
    userChat: userChat
  );
}