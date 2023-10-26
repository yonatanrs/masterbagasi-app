import '../user_chat_wrapper.dart';

class UpdateReadStatusOrderConversationResponse {
  String id;
  UserChatWrapper? userOne;
  UserChatWrapper? userTwo;

  UpdateReadStatusOrderConversationResponse({
    required this.id,
    required this.userOne,
    required this.userTwo
  });
}