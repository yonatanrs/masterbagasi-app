import '../domain/entity/chat/help/answer_help_conversation_parameter.dart';
import '../domain/entity/chat/help/answer_help_conversation_response.dart';
import '../domain/entity/chat/help/create_help_conversation_parameter.dart';
import '../domain/entity/chat/help/create_help_conversation_response.dart';
import '../domain/entity/chat/help/get_help_message_by_user_parameter.dart';
import '../domain/entity/chat/help/get_help_message_by_user_response.dart';
import '../domain/entity/user/getuser/get_user_parameter.dart';
import '../domain/entity/user/getuser/get_user_response.dart';
import '../domain/usecase/answer_help_conversation_use_case.dart';
import '../domain/usecase/create_help_conversation_use_case.dart';
import '../domain/usecase/get_help_message_by_user_use_case.dart';
import '../domain/usecase/get_user_use_case.dart';
import '../misc/load_data_result.dart';
import 'base_getx_controller.dart';

class HelpChatController extends BaseGetxController {
  final GetHelpMessageByUserUseCase getHelpMessageByUserUseCase;
  final CreateHelpConversationUseCase createHelpConversationUseCase;
  final AnswerHelpConversationUseCase answerHelpConversationUseCase;
  final GetUserUseCase getUserUseCase;

  HelpChatController(
    super.controllerManager,
    this.getHelpMessageByUserUseCase,
    this.createHelpConversationUseCase,
    this.answerHelpConversationUseCase,
    this.getUserUseCase
  );

  Future<LoadDataResult<GetHelpMessageByUserResponse>> getHelpMessageByUser(GetHelpMessageByUserParameter getHelpMessageByUserParameter) {
    return getHelpMessageByUserUseCase.execute(getHelpMessageByUserParameter).future(
      parameter: apiRequestManager.addRequestToCancellationPart("help-message-by-user").value
    );
  }

  Future<LoadDataResult<CreateHelpConversationResponse>> createHelpConversation(CreateHelpConversationParameter createHelpConversationParameter) {
    return createHelpConversationUseCase.execute(createHelpConversationParameter).future(
      parameter: apiRequestManager.addRequestToCancellationPart("create-help-conversation").value
    );
  }

  Future<LoadDataResult<AnswerHelpConversationResponse>> answerHelpConversation(AnswerHelpConversationParameter answerHelpConversationParameter) {
    return answerHelpConversationUseCase.execute(answerHelpConversationParameter).future(
      parameter: apiRequestManager.addRequestToCancellationPart("answer-help-conversation").value
    );
  }

  Future<LoadDataResult<GetUserResponse>> getUser(GetUserParameter getUserParameter) {
    return getUserUseCase.execute(getUserParameter).future(
      parameter: apiRequestManager.addRequestToCancellationPart("get-user").value
    );
  }
}