import '../../misc/load_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../entity/chat/order/answer_order_conversation_parameter.dart';
import '../entity/chat/order/answer_order_conversation_response.dart';
import '../repository/chat_repository.dart';

class AnswerOrderConversationUseCase {
  final ChatRepository chatRepository;

  const AnswerOrderConversationUseCase({
    required this.chatRepository
  });

  FutureProcessing<LoadDataResult<AnswerOrderConversationResponse>> execute(AnswerOrderConversationParameter answerOrderConversationParameter) {
    return chatRepository.answerOrderConversation(answerOrderConversationParameter);
  }
}