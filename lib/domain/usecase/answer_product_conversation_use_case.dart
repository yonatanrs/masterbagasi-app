import '../../misc/load_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../entity/chat/product/answer_product_conversation_parameter.dart';
import '../entity/chat/product/answer_product_conversation_response.dart';
import '../repository/chat_repository.dart';

class AnswerProductConversationUseCase {
  final ChatRepository chatRepository;

  const AnswerProductConversationUseCase({
    required this.chatRepository
  });

  FutureProcessing<LoadDataResult<AnswerProductConversationResponse>> execute(AnswerProductConversationParameter answerProductConversationParameter) {
    return chatRepository.answerProductConversation(answerProductConversationParameter);
  }
}