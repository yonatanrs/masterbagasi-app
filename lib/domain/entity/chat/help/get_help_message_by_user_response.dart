import '../user_chat_wrapper.dart';
import 'help_message.dart';

class GetHelpMessageByUserResponse {
  String id;
  UserChatWrapper? userOne;
  UserChatWrapper? userTwo;
  int unreadMessagesCount;
  List<HelpMessage> helpMessageList;

  GetHelpMessageByUserResponse({
    required this.id,
    required this.userOne,
    required this.userTwo,
    required this.unreadMessagesCount,
    required this.helpMessageList
  });
}