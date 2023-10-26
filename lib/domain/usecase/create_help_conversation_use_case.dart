import '../../misc/load_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../entity/chat/help/create_help_conversation_parameter.dart';
import '../entity/chat/help/create_help_conversation_response.dart';
import '../repository/chat_repository.dart';

class CreateHelpConversationUseCase {
  final ChatRepository chatRepository;

  const CreateHelpConversationUseCase({
    required this.chatRepository
  });

  FutureProcessing<LoadDataResult<CreateHelpConversationResponse>> execute(CreateHelpConversationParameter createHelpConversationParameter) {
    return chatRepository.createHelpConversation(createHelpConversationParameter);
  }
}