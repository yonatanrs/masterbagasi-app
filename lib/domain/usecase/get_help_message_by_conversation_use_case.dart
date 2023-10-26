import '../../misc/load_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../entity/chat/help/get_help_message_by_conversation_parameter.dart';
import '../entity/chat/help/get_help_message_by_conversation_response.dart';
import '../repository/chat_repository.dart';

class GetHelpMessageByConversationUseCase {
  final ChatRepository chatRepository;

  const GetHelpMessageByConversationUseCase({
    required this.chatRepository
  });

  FutureProcessing<LoadDataResult<GetHelpMessageByConversationResponse>> execute(GetHelpMessageByConversationParameter getHelpMessageByConversationParameter) {
    return chatRepository.getHelpMessageByConversation(getHelpMessageByConversationParameter);
  }
}