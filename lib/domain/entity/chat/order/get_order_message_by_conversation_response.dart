import '../user_chat_wrapper.dart';
import 'order_message.dart';

class GetOrderMessageByConversationResponse {
  String id;
  UserChatWrapper? userOne;
  UserChatWrapper? userTwo;
  List<OrderMessage> orderMessageList;

  GetOrderMessageByConversationResponse({
    required this.id,
    required this.userOne,
    required this.userTwo,
    required this.orderMessageList
  });
}