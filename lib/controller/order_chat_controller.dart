import '../domain/entity/chat/order/answer_order_conversation_parameter.dart';
import '../domain/entity/chat/order/answer_order_conversation_response.dart';
import '../domain/entity/chat/order/create_order_conversation_parameter.dart';
import '../domain/entity/chat/order/create_order_conversation_response.dart';
import '../domain/entity/chat/order/get_order_message_by_user_parameter.dart';
import '../domain/entity/chat/order/get_order_message_by_user_response.dart';
import '../domain/entity/user/getuser/get_user_parameter.dart';
import '../domain/entity/user/getuser/get_user_response.dart';
import '../domain/usecase/answer_order_conversation_use_case.dart';
import '../domain/usecase/create_order_conversation_use_case.dart';
import '../domain/usecase/get_order_message_by_user_use_case.dart';
import '../domain/usecase/get_user_use_case.dart';
import '../misc/load_data_result.dart';
import 'base_getx_controller.dart';

class OrderChatController extends BaseGetxController {
  final GetOrderMessageByUserUseCase getOrderMessageByUserUseCase;
  final CreateOrderConversationUseCase createOrderConversationUseCase;
  final AnswerOrderConversationUseCase answerOrderConversationUseCase;
  final GetUserUseCase getUserUseCase;

  OrderChatController(
    super.controllerManager,
    this.getOrderMessageByUserUseCase,
    this.createOrderConversationUseCase,
    this.answerOrderConversationUseCase,
    this.getUserUseCase
  );

  Future<LoadDataResult<GetOrderMessageByUserResponse>> getOrderMessageByUser(GetOrderMessageByUserParameter getOrderMessageByUserParameter) {
    return getOrderMessageByUserUseCase.execute(getOrderMessageByUserParameter).future(
      parameter: apiRequestManager.addRequestToCancellationPart("order-message-by-user").value
    );
  }

  Future<LoadDataResult<CreateOrderConversationResponse>> createOrderConversation(CreateOrderConversationParameter createOrderConversationParameter) {
    return createOrderConversationUseCase.execute(createOrderConversationParameter).future(
      parameter: apiRequestManager.addRequestToCancellationPart("create-order-conversation").value
    );
  }

  Future<LoadDataResult<AnswerOrderConversationResponse>> answerOrderConversation(AnswerOrderConversationParameter answerOrderConversationParameter) {
    return answerOrderConversationUseCase.execute(answerOrderConversationParameter).future(
      parameter: apiRequestManager.addRequestToCancellationPart("answer-order-conversation").value
    );
  }

  Future<LoadDataResult<GetUserResponse>> getUser(GetUserParameter getUserParameter) {
    return getUserUseCase.execute(getUserParameter).future(
      parameter: apiRequestManager.addRequestToCancellationPart("get-user").value
    );
  }
}