import '../user/user.dart';
import 'user_chat_status.dart';

class UserChatWrapper {
  User user;
  UserChatStatus userChatStatus;

  UserChatWrapper({
    required this.user,
    required this.userChatStatus
  });
}