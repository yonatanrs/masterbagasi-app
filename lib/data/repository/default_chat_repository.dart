import '../../domain/entity/chat/help/answer_help_conversation_parameter.dart';
import '../../domain/entity/chat/help/answer_help_conversation_response.dart';
import '../../domain/entity/chat/help/create_help_conversation_parameter.dart';
import '../../domain/entity/chat/help/create_help_conversation_response.dart';
import '../../domain/entity/chat/help/get_help_message_by_conversation_parameter.dart';
import '../../domain/entity/chat/help/get_help_message_by_conversation_response.dart';
import '../../domain/entity/chat/help/get_help_message_by_user_parameter.dart';
import '../../domain/entity/chat/help/get_help_message_by_user_response.dart';
import '../../domain/entity/chat/help/update_read_status_help_conversation_parameter.dart';
import '../../domain/entity/chat/help/update_read_status_help_conversation_response.dart';
import '../../domain/entity/chat/order/answer_order_conversation_parameter.dart';
import '../../domain/entity/chat/order/answer_order_conversation_response.dart';
import '../../domain/entity/chat/order/create_order_conversation_parameter.dart';
import '../../domain/entity/chat/order/create_order_conversation_response.dart';
import '../../domain/entity/chat/order/get_order_message_by_conversation_parameter.dart';
import '../../domain/entity/chat/order/get_order_message_by_conversation_response.dart';
import '../../domain/entity/chat/order/get_order_message_by_user_parameter.dart';
import '../../domain/entity/chat/order/get_order_message_by_user_response.dart';
import '../../domain/entity/chat/order/update_read_status_order_conversation_parameter.dart';
import '../../domain/entity/chat/order/update_read_status_order_conversation_response.dart';
import '../../domain/entity/chat/product/answer_product_conversation_parameter.dart';
import '../../domain/entity/chat/product/answer_product_conversation_response.dart';
import '../../domain/entity/chat/product/create_product_conversation_parameter.dart';
import '../../domain/entity/chat/product/create_product_conversation_response.dart';
import '../../domain/entity/chat/product/get_product_message_by_conversation_parameter.dart';
import '../../domain/entity/chat/product/get_product_message_by_conversation_response.dart';
import '../../domain/entity/chat/product/get_product_message_by_product_parameter.dart';
import '../../domain/entity/chat/product/get_product_message_by_product_response.dart';
import '../../domain/entity/chat/product/get_product_message_by_user_parameter.dart';
import '../../domain/entity/chat/product/get_product_message_by_user_response.dart';
import '../../domain/entity/chat/product/update_read_status_product_conversation_parameter.dart';
import '../../domain/entity/chat/product/update_read_status_product_conversation_response.dart';
import '../../domain/repository/chat_repository.dart';
import '../../misc/load_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../datasource/chatdatasource/chat_data_source.dart';

class DefaultChatRepository implements ChatRepository {
  final ChatDataSource chatDataSource;

  const DefaultChatRepository({
    required this.chatDataSource
  });

  @override
  FutureProcessing<LoadDataResult<AnswerHelpConversationResponse>> answerHelpConversation(AnswerHelpConversationParameter answerHelpConversationParameter) {
    return chatDataSource.answerHelpConversation(answerHelpConversationParameter).mapToLoadDataResult<AnswerHelpConversationResponse>();
  }

  @override
  FutureProcessing<LoadDataResult<CreateHelpConversationResponse>> createHelpConversation(CreateHelpConversationParameter createHelpConversationParameter) {
    return chatDataSource.createHelpConversation(createHelpConversationParameter).mapToLoadDataResult<CreateHelpConversationResponse>();
  }

  @override
  FutureProcessing<LoadDataResult<UpdateReadStatusHelpConversationResponse>> updateReadStatusHelpConversation(UpdateReadStatusHelpConversationParameter updateReadStatusHelpConversationParameter) {
    return chatDataSource.updateReadStatusHelpConversation(updateReadStatusHelpConversationParameter).mapToLoadDataResult<UpdateReadStatusHelpConversationResponse>();
  }

  @override
  FutureProcessing<LoadDataResult<GetHelpMessageByConversationResponse>> getHelpMessageByConversation(GetHelpMessageByConversationParameter getHelpMessageByConversationParameter) {
    return chatDataSource.getHelpMessageByConversationResponse(getHelpMessageByConversationParameter).mapToLoadDataResult<GetHelpMessageByConversationResponse>();
  }

  @override
  FutureProcessing<LoadDataResult<GetHelpMessageByUserResponse>> getHelpMessageByUser(GetHelpMessageByUserParameter getHelpMessageByUserParameter) {
    return chatDataSource.getHelpMessageByUserResponse(getHelpMessageByUserParameter).mapToLoadDataResult<GetHelpMessageByUserResponse>();
  }

  @override
  FutureProcessing<LoadDataResult<CreateOrderConversationResponse>> createOrderConversation(CreateOrderConversationParameter createOrderConversationParameter) {
    return chatDataSource.createOrderConversation(createOrderConversationParameter).mapToLoadDataResult<CreateOrderConversationResponse>();
  }

  @override
  FutureProcessing<LoadDataResult<UpdateReadStatusOrderConversationResponse>> updateReadStatusOrderConversation(UpdateReadStatusOrderConversationParameter updateReadStatusOrderConversationParameter) {
    return chatDataSource.updateReadStatusOrderConversation(updateReadStatusOrderConversationParameter).mapToLoadDataResult<UpdateReadStatusOrderConversationResponse>();
  }

  @override
  FutureProcessing<LoadDataResult<AnswerOrderConversationResponse>> answerOrderConversation(AnswerOrderConversationParameter answerOrderConversationParameter) {
    return chatDataSource.answerOrderConversation(answerOrderConversationParameter).mapToLoadDataResult<AnswerOrderConversationResponse>();
  }

  @override
  FutureProcessing<LoadDataResult<GetOrderMessageByConversationResponse>> getOrderMessageByConversation(GetOrderMessageByConversationParameter getOrderMessageByConversationParameter) {
    return chatDataSource.getOrderMessageByConversation(getOrderMessageByConversationParameter).mapToLoadDataResult<GetOrderMessageByConversationResponse>();
  }

  @override
  FutureProcessing<LoadDataResult<GetOrderMessageByUserResponse>> getOrderMessageByUser(GetOrderMessageByUserParameter getOrderMessageByUserParameter) {
    return chatDataSource.getOrderMessageByUser(getOrderMessageByUserParameter).mapToLoadDataResult<GetOrderMessageByUserResponse>();
  }

  @override
  FutureProcessing<LoadDataResult<CreateProductConversationResponse>> createProductConversation(CreateProductConversationParameter createProductConversationParameter) {
    return chatDataSource.createProductConversation(createProductConversationParameter).mapToLoadDataResult<CreateProductConversationResponse>();
  }

  @override
  FutureProcessing<LoadDataResult<UpdateReadStatusProductConversationResponse>> updateReadStatusProductConversation(UpdateReadStatusProductConversationParameter updateReadStatusProductConversationParameter) {
    return chatDataSource.updateReadStatusProductConversation(updateReadStatusProductConversationParameter).mapToLoadDataResult<UpdateReadStatusProductConversationResponse>();
  }

  @override
  FutureProcessing<LoadDataResult<AnswerProductConversationResponse>> answerProductConversation(AnswerProductConversationParameter answerProductConversationParameter) {
    return chatDataSource.answerProductConversation(answerProductConversationParameter).mapToLoadDataResult<AnswerProductConversationResponse>();
  }

  @override
  FutureProcessing<LoadDataResult<GetProductMessageByConversationResponse>> getProductMessageByConversation(GetProductMessageByConversationParameter getProductMessageByConversationParameter) {
    return chatDataSource.getProductMessageByConversation(getProductMessageByConversationParameter).mapToLoadDataResult<GetProductMessageByConversationResponse>();
  }

  @override
  FutureProcessing<LoadDataResult<GetProductMessageByUserResponse>> getProductMessageByUser(GetProductMessageByUserParameter getProductMessageByUserParameter) {
    return chatDataSource.getProductMessageByUser(getProductMessageByUserParameter).mapToLoadDataResult<GetProductMessageByUserResponse>();
  }

  @override
  FutureProcessing<LoadDataResult<GetProductMessageByProductResponse>> getProductMessageByProduct(GetProductMessageByProductParameter getProductMessageByUserParameter) {
    return chatDataSource.getProductMessageByProduct(getProductMessageByUserParameter).mapToLoadDataResult<GetProductMessageByProductResponse>();
  }
}