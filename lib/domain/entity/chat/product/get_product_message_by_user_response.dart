import '../user_chat_wrapper.dart';
import 'product_message.dart';

class GetProductMessageByUserResponse {
  String id;
  String? productId;
  UserChatWrapper? userOne;
  UserChatWrapper? userTwo;
  int unreadMessagesCount;
  List<ProductMessage> productMessageList;

  GetProductMessageByUserResponse({
    required this.id,
    required this.userOne,
    required this.userTwo,
    required this.unreadMessagesCount,
    required this.productMessageList
  });
}