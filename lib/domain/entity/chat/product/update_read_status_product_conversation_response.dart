import '../user_chat_wrapper.dart';

class UpdateReadStatusProductConversationResponse {
  String id;
  UserChatWrapper? userOne;
  UserChatWrapper? userTwo;

  UpdateReadStatusProductConversationResponse({
    required this.id,
    required this.userOne,
    required this.userTwo
  });
}