import '../user_chat_wrapper.dart';

class UpdateReadStatusHelpConversationResponse {
  String id;
  UserChatWrapper? userOne;
  UserChatWrapper? userTwo;

  UpdateReadStatusHelpConversationResponse({
    required this.id,
    required this.userOne,
    required this.userTwo
  });
}