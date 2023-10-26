import '../../misc/load_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../entity/chat/product/create_product_conversation_parameter.dart';
import '../entity/chat/product/create_product_conversation_response.dart';
import '../repository/chat_repository.dart';

class CreateProductConversationUseCase {
  final ChatRepository chatRepository;

  const CreateProductConversationUseCase({
    required this.chatRepository
  });

  FutureProcessing<LoadDataResult<CreateProductConversationResponse>> execute(CreateProductConversationParameter createProductConversationParameter) {
    return chatRepository.createProductConversation(createProductConversationParameter);
  }
}