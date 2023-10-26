import '../../misc/load_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../entity/chat/help/update_read_status_help_conversation_parameter.dart';
import '../entity/chat/help/update_read_status_help_conversation_response.dart';
import '../repository/chat_repository.dart';

class UpdateReadStatusHelpConversationUseCase {
  final ChatRepository chatRepository;

  const UpdateReadStatusHelpConversationUseCase({
    required this.chatRepository
  });

  FutureProcessing<LoadDataResult<UpdateReadStatusHelpConversationResponse>> execute(UpdateReadStatusHelpConversationParameter updateReadStatusHelpConversationParameter) {
    return chatRepository.updateReadStatusHelpConversation(updateReadStatusHelpConversationParameter);
  }
}