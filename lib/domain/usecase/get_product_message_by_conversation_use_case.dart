import '../../misc/load_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../entity/chat/product/get_product_message_by_conversation_parameter.dart';
import '../entity/chat/product/get_product_message_by_conversation_response.dart';
import '../repository/chat_repository.dart';

class GetProductMessageByConversationUseCase {
  final ChatRepository chatRepository;

  const GetProductMessageByConversationUseCase({
    required this.chatRepository
  });

  FutureProcessing<LoadDataResult<GetProductMessageByConversationResponse>> execute(GetProductMessageByConversationParameter getProductMessageByConversationParameter) {
    return chatRepository.getProductMessageByConversation(getProductMessageByConversationParameter);
  }
}