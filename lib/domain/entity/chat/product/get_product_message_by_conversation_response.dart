import '../user_chat_wrapper.dart';
import 'product_message.dart';

class GetProductMessageByConversationResponse {
  String id;
  String? productId;
  UserChatWrapper? userOne;
  UserChatWrapper? userTwo;
  List<ProductMessage> productMessageList;

  GetProductMessageByConversationResponse({
    required this.id,
    required this.productId,
    required this.userOne,
    required this.userTwo,
    required this.productMessageList
  });
}