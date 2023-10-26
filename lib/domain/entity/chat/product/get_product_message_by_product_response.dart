import '../user_chat_wrapper.dart';
import 'product_message.dart';

class GetProductMessageByProductResponse {
  String id;
  UserChatWrapper? userOne;
  UserChatWrapper? userTwo;
  int unreadMessagesCount;
  List<ProductMessage> productMessageList;

  GetProductMessageByProductResponse({
    required this.id,
    required this.userOne,
    required this.userTwo,
    required this.unreadMessagesCount,
    required this.productMessageList
  });
}