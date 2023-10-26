import '../../misc/load_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../entity/chat/order/create_order_conversation_parameter.dart';
import '../entity/chat/order/create_order_conversation_response.dart';
import '../repository/chat_repository.dart';

class CreateOrderConversationUseCase {
  final ChatRepository chatRepository;

  const CreateOrderConversationUseCase({
    required this.chatRepository
  });

  FutureProcessing<LoadDataResult<CreateOrderConversationResponse>> execute(CreateOrderConversationParameter createOrderConversationParameter) {
    return chatRepository.createOrderConversation(createOrderConversationParameter);
  }
}