import '../user_chat_wrapper.dart';
import 'help_message.dart';

class GetHelpMessageByConversationResponse {
  String id;
  UserChatWrapper? userOne;
  UserChatWrapper? userTwo;
  List<HelpMessage> helpMessageList;

  GetHelpMessageByConversationResponse({
    required this.id,
    required this.userOne,
    required this.userTwo,
    required this.helpMessageList
  });
}