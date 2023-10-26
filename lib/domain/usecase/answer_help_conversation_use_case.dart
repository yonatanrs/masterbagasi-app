import '../../misc/load_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../entity/chat/help/answer_help_conversation_parameter.dart';
import '../entity/chat/help/answer_help_conversation_response.dart';
import '../repository/chat_repository.dart';

class AnswerHelpConversationUseCase {
  final ChatRepository chatRepository;

  const AnswerHelpConversationUseCase({
    required this.chatRepository
  });

  FutureProcessing<LoadDataResult<AnswerHelpConversationResponse>> execute(AnswerHelpConversationParameter answerHelpConversationParameter) {
    return chatRepository.answerHelpConversation(answerHelpConversationParameter);
  }
}