import '../../user/user.dart';
import '../user_chat.dart';
import '../user_message.dart';

class HelpMessage extends UserMessage {
  HelpMessage({
    required String id,
    required String helpConversationId,
    required String userId,
    required String message,
    required int readStatus,
    required DateTime? createdAt,
    required DateTime? updatedAt,
    required DateTime? deletedAt,
    required UserChat userChat
  }) : super(
    id: id,
    conversationId: helpConversationId,
    userId: userId,
    message: message,
    readStatus: readStatus,
    createdAt: createdAt,
    updatedAt: updatedAt,
    deletedAt: deletedAt,
    userChat: userChat
  );
}