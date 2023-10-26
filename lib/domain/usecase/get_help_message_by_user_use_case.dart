import '../../misc/load_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../entity/chat/help/get_help_message_by_user_parameter.dart';
import '../entity/chat/help/get_help_message_by_user_response.dart';
import '../repository/chat_repository.dart';

class GetHelpMessageByUserUseCase {
  final ChatRepository chatRepository;

  const GetHelpMessageByUserUseCase({
    required this.chatRepository
  });

  FutureProcessing<LoadDataResult<GetHelpMessageByUserResponse>> execute(GetHelpMessageByUserParameter getHelpMessageByUserParameter) {
    return chatRepository.getHelpMessageByUser(getHelpMessageByUserParameter);
  }
}