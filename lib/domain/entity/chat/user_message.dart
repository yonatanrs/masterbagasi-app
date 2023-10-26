import 'user_chat.dart';

abstract class UserMessage {
  String id;
  String conversationId;
  String userId;
  String message;
  int readStatus;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;
  UserChat userChat;

  UserMessage({
    required this.id,
    required this.conversationId,
    required this.userId,
    required this.message,
    required this.readStatus,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.userChat
  });
}