import '../../misc/load_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../entity/chat/product/update_read_status_product_conversation_parameter.dart';
import '../entity/chat/product/update_read_status_product_conversation_response.dart';
import '../repository/chat_repository.dart';

class UpdateReadStatusProductConversationUseCase {
  final ChatRepository chatRepository;

  const UpdateReadStatusProductConversationUseCase({
    required this.chatRepository
  });

  FutureProcessing<LoadDataResult<UpdateReadStatusProductConversationResponse>> execute(UpdateReadStatusProductConversationParameter updateReadStatusProductConversationParameter) {
    return chatRepository.updateReadStatusProductConversation(updateReadStatusProductConversationParameter);
  }
}