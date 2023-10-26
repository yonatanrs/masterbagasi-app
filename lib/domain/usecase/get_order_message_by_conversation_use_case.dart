import '../../misc/load_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../entity/chat/order/get_order_message_by_conversation_parameter.dart';
import '../entity/chat/order/get_order_message_by_conversation_response.dart';
import '../repository/chat_repository.dart';

class GetOrderMessageByConversationUseCase {
  final ChatRepository chatRepository;

  const GetOrderMessageByConversationUseCase({
    required this.chatRepository
  });

  FutureProcessing<LoadDataResult<GetOrderMessageByConversationResponse>> execute(GetOrderMessageByConversationParameter getOrderMessageByConversationParameter) {
    return chatRepository.getOrderMessageByConversation(getOrderMessageByConversationParameter);
  }
}