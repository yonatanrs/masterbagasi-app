import '../domain/entity/chat/product/answer_product_conversation_parameter.dart';
import '../domain/entity/chat/product/answer_product_conversation_response.dart';
import '../domain/entity/chat/product/create_product_conversation_parameter.dart';
import '../domain/entity/chat/product/create_product_conversation_response.dart';
import '../domain/entity/chat/product/get_product_message_by_product_parameter.dart';
import '../domain/entity/chat/product/get_product_message_by_product_response.dart';
import '../domain/entity/chat/product/get_product_message_by_user_parameter.dart';
import '../domain/entity/chat/product/get_product_message_by_user_response.dart';
import '../domain/entity/user/getuser/get_user_parameter.dart';
import '../domain/entity/user/getuser/get_user_response.dart';
import '../domain/usecase/answer_product_conversation_use_case.dart';
import '../domain/usecase/create_product_conversation_use_case.dart';
import '../domain/usecase/get_product_message_by_product_use_case.dart';
import '../domain/usecase/get_product_message_by_user_use_case.dart';
import '../domain/usecase/get_user_use_case.dart';
import '../misc/load_data_result.dart';
import 'base_getx_controller.dart';

class ProductChatController extends BaseGetxController {
  final GetProductMessageByUserUseCase getProductMessageByUserUseCase;
  final GetProductMessageByProductUseCase getProductMessageByProductUseCase;
  final CreateProductConversationUseCase createProductConversationUseCase;
  final AnswerProductConversationUseCase answerProductConversationUseCase;
  final GetUserUseCase getUserUseCase;

  ProductChatController(
    super.controllerManager,
    this.getProductMessageByUserUseCase,
    this.getProductMessageByProductUseCase,
    this.createProductConversationUseCase,
    this.answerProductConversationUseCase,
    this.getUserUseCase
  );

  Future<LoadDataResult<GetProductMessageByUserResponse>> getProductMessageByUser(GetProductMessageByUserParameter getProductMessageByUserParameter) {
    return getProductMessageByUserUseCase.execute(getProductMessageByUserParameter).future(
      parameter: apiRequestManager.addRequestToCancellationPart("chat-message-by-user").value
    );
  }

  Future<LoadDataResult<GetProductMessageByProductResponse>> getProductMessageByProduct(GetProductMessageByProductParameter getProductMessageByProductParameter) {
    return getProductMessageByProductUseCase.execute(getProductMessageByProductParameter).future(
      parameter: apiRequestManager.addRequestToCancellationPart("chat-message-by-product").value
    );
  }

  Future<LoadDataResult<CreateProductConversationResponse>> createChatConversation(CreateProductConversationParameter createProductConversationParameter) {
    return createProductConversationUseCase.execute(createProductConversationParameter).future(
      parameter: apiRequestManager.addRequestToCancellationPart("create-chat-conversation").value
    );
  }

  Future<LoadDataResult<AnswerProductConversationResponse>> answerProductConversation(AnswerProductConversationParameter answerProductConversationParameter) {
    return answerProductConversationUseCase.execute(answerProductConversationParameter).future(
      parameter: apiRequestManager.addRequestToCancellationPart("answer-product-conversation").value
    );
  }

  Future<LoadDataResult<GetUserResponse>> getUser(GetUserParameter getUserParameter) {
    return getUserUseCase.execute(getUserParameter).future(
      parameter: apiRequestManager.addRequestToCancellationPart("get-user").value
    );
  }
}