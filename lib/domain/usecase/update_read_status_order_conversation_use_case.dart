import '../../misc/load_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../entity/chat/order/update_read_status_order_conversation_parameter.dart';
import '../entity/chat/order/update_read_status_order_conversation_response.dart';
import '../repository/chat_repository.dart';

class UpdateReadStatusOrderConversationUseCase {
  final ChatRepository chatRepository;

  const UpdateReadStatusOrderConversationUseCase({
    required this.chatRepository
  });

  FutureProcessing<LoadDataResult<UpdateReadStatusOrderConversationResponse>> execute(UpdateReadStatusOrderConversationParameter updateReadStatusOrderConversationParameter) {
    return chatRepository.updateReadStatusOrderConversation(updateReadStatusOrderConversationParameter);
  }
}