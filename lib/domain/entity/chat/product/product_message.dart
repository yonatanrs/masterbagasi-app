import '../user_chat.dart';
import '../user_message.dart';

class ProductMessage extends UserMessage {
  ProductMessage({
    required String id,
    required String productConversationId,
    required String userId,
    required String message,
    required int readStatus,
    required DateTime? createdAt,
    required DateTime? updatedAt,
    required DateTime? deletedAt,
    required UserChat userChat
  }) : super(
    id: id,
    conversationId: productConversationId,
    userId: userId,
    message: message,
    readStatus: readStatus,
    createdAt: createdAt,
    updatedAt: updatedAt,
    deletedAt: deletedAt,
    userChat: userChat
  );
}