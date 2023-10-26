import '../user_chat_wrapper.dart';
import 'order_message.dart';

class GetOrderMessageByUserResponse {
  String id;
  UserChatWrapper? userOne;
  UserChatWrapper? userTwo;
  int unreadMessagesCount;
  List<OrderMessage> orderMessageList;

  GetOrderMessageByUserResponse({
    required this.id,
    required this.userOne,
    required this.userTwo,
    required this.unreadMessagesCount,
    required this.orderMessageList
  });
}