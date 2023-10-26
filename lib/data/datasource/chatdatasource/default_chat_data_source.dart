import 'package:dio/dio.dart';
import 'package:masterbagasi/data/entitymappingext/chat_entity_mapping_ext.dart';
import 'package:masterbagasi/misc/ext/future_ext.dart';
import 'package:masterbagasi/misc/ext/response_wrapper_ext.dart';

import '../../../domain/entity/chat/help/answer_help_conversation_parameter.dart';
import '../../../domain/entity/chat/help/answer_help_conversation_response.dart';
import '../../../domain/entity/chat/help/create_help_conversation_parameter.dart';
import '../../../domain/entity/chat/help/create_help_conversation_response.dart';
import '../../../domain/entity/chat/help/get_help_message_by_conversation_parameter.dart';
import '../../../domain/entity/chat/help/get_help_message_by_conversation_response.dart';
import '../../../domain/entity/chat/help/get_help_message_by_user_parameter.dart';
import '../../../domain/entity/chat/help/get_help_message_by_user_response.dart';
import '../../../domain/entity/chat/help/update_read_status_help_conversation_parameter.dart';
import '../../../domain/entity/chat/help/update_read_status_help_conversation_response.dart';
import '../../../domain/entity/chat/order/answer_order_conversation_parameter.dart';
import '../../../domain/entity/chat/order/answer_order_conversation_response.dart';
import '../../../domain/entity/chat/order/create_order_conversation_parameter.dart';
import '../../../domain/entity/chat/order/create_order_conversation_response.dart';
import '../../../domain/entity/chat/order/get_order_message_by_conversation_parameter.dart';
import '../../../domain/entity/chat/order/get_order_message_by_conversation_response.dart';
import '../../../domain/entity/chat/order/get_order_message_by_user_parameter.dart';
import '../../../domain/entity/chat/order/get_order_message_by_user_response.dart';
import '../../../domain/entity/chat/order/update_read_status_order_conversation_parameter.dart';
import '../../../domain/entity/chat/order/update_read_status_order_conversation_response.dart';
import '../../../domain/entity/chat/product/answer_product_conversation_parameter.dart';
import '../../../domain/entity/chat/product/answer_product_conversation_response.dart';
import '../../../domain/entity/chat/product/create_product_conversation_parameter.dart';
import '../../../domain/entity/chat/product/create_product_conversation_response.dart';
import '../../../domain/entity/chat/product/get_product_message_by_conversation_parameter.dart';
import '../../../domain/entity/chat/product/get_product_message_by_conversation_response.dart';
import '../../../domain/entity/chat/product/get_product_message_by_product_parameter.dart';
import '../../../domain/entity/chat/product/get_product_message_by_product_response.dart';
import '../../../domain/entity/chat/product/get_product_message_by_user_parameter.dart';
import '../../../domain/entity/chat/product/get_product_message_by_user_response.dart';
import '../../../domain/entity/chat/product/update_read_status_product_conversation_parameter.dart';
import '../../../domain/entity/chat/product/update_read_status_product_conversation_response.dart';
import '../../../misc/option_builder.dart';
import '../../../misc/processing/dio_http_client_processing.dart';
import '../../../misc/processing/future_processing.dart';
import 'chat_data_source.dart';

class DefaultChatDataSource implements ChatDataSource {
  final Dio dio;

  const DefaultChatDataSource({
    required this.dio
  });

  @override
  FutureProcessing<CreateHelpConversationResponse> createHelpConversation(CreateHelpConversationParameter createHelpConversationParameter) {
    FormData formData = FormData.fromMap(
      <String, dynamic> {
        "message": createHelpConversationParameter.message
      }
    );
    return DioHttpClientProcessing((cancelToken) {
      return dio.post("/chat-help", data: formData, cancelToken: cancelToken, options: OptionsBuilder.multipartData().build())
        .map<CreateHelpConversationResponse>(onMap: (value) => value.wrapResponse().mapFromResponseToCreateHelpConversationResponse());
    });
  }

  @override
  FutureProcessing<AnswerHelpConversationResponse> answerHelpConversation(AnswerHelpConversationParameter answerHelpConversationParameter) {
    FormData formData = FormData.fromMap(
      <String, dynamic> {
        "message": answerHelpConversationParameter.message
      }
    );
    return DioHttpClientProcessing((cancelToken) {
      return dio.post("/chat-help/${answerHelpConversationParameter.helpConversationId}/message", data: formData, cancelToken: cancelToken, options: OptionsBuilder.multipartData().build())
        .map<AnswerHelpConversationResponse>(onMap: (value) => value.wrapResponse().mapFromResponseToAnswerHelpConversationResponse());
    });
  }

  @override
  FutureProcessing<UpdateReadStatusHelpConversationResponse> updateReadStatusHelpConversation(UpdateReadStatusHelpConversationParameter updateReadStatusHelpConversationParameter) {
    return DioHttpClientProcessing((cancelToken) {
      return dio.post("/chat-help/update-status/${updateReadStatusHelpConversationParameter.helpConversationId}", cancelToken: cancelToken, options: OptionsBuilder.multipartData().build())
        .map<UpdateReadStatusHelpConversationResponse>(onMap: (value) => value.wrapResponse().mapFromResponseToUpdateReadStatusHelpConversationResponse());
    });
  }

  @override
  FutureProcessing<GetHelpMessageByConversationResponse> getHelpMessageByConversationResponse(GetHelpMessageByConversationParameter getHelpMessageByConversationParameter) {
    return DioHttpClientProcessing((cancelToken) {
      return dio.get("/chat-help/message/${getHelpMessageByConversationParameter.helpConversationId}", cancelToken: cancelToken)
        .map<GetHelpMessageByConversationResponse>(onMap: (value) => value.wrapResponse().mapFromResponseToGetHelpMessageByConversationResponse());
    });
  }

  @override
  FutureProcessing<GetHelpMessageByUserResponse> getHelpMessageByUserResponse(GetHelpMessageByUserParameter getHelpMessageByUserParameter) {
    return DioHttpClientProcessing((cancelToken) {
      return dio.get("/chat-help/user", cancelToken: cancelToken)
        .map<GetHelpMessageByUserResponse>(onMap: (value) => value.wrapResponse().mapFromResponseToGetHelpMessageByUserResponse());
    });
  }

  @override
  FutureProcessing<CreateOrderConversationResponse> createOrderConversation(CreateOrderConversationParameter createOrderConversationParameter) {
    FormData formData = FormData.fromMap(
      <String, dynamic> {
        "message": createOrderConversationParameter.message,
        "product_id": createOrderConversationParameter.productId
      }
    );
    return DioHttpClientProcessing((cancelToken) {
      return dio.post("/chat-order", data: formData, cancelToken: cancelToken, options: OptionsBuilder.multipartData().build())
        .map<CreateOrderConversationResponse>(onMap: (value) => value.wrapResponse().mapFromResponseToCreateOrderConversationResponse());
    });
  }

  @override
  FutureProcessing<UpdateReadStatusOrderConversationResponse> updateReadStatusOrderConversation(UpdateReadStatusOrderConversationParameter updateReadStatusOrderConversationParameter) {
    return DioHttpClientProcessing((cancelToken) {
      return dio.post("/chat-order/update-status/${updateReadStatusOrderConversationParameter.orderConversationId}", cancelToken: cancelToken, options: OptionsBuilder.multipartData().build())
        .map<UpdateReadStatusOrderConversationResponse>(onMap: (value) => value.wrapResponse().mapFromResponseToUpdateReadStatusOrderConversationResponse());
    });
  }

  @override
  FutureProcessing<AnswerOrderConversationResponse> answerOrderConversation(AnswerOrderConversationParameter answerOrderConversationParameter) {
    FormData formData = FormData.fromMap(
      <String, dynamic> {
        "message": answerOrderConversationParameter.message
      }
    );
    return DioHttpClientProcessing((cancelToken) {
      return dio.post("/chat-order/${answerOrderConversationParameter.orderConversationId}/message", data: formData, cancelToken: cancelToken, options: OptionsBuilder.multipartData().build())
        .map<AnswerOrderConversationResponse>(onMap: (value) => value.wrapResponse().mapFromResponseToAnswerOrderConversationResponse());
    });
  }

  @override
  FutureProcessing<GetOrderMessageByConversationResponse> getOrderMessageByConversation(GetOrderMessageByConversationParameter getOrderMessageByConversationParameter) {
    return DioHttpClientProcessing((cancelToken) {
      return dio.get("/chat-order/message/${getOrderMessageByConversationParameter.orderConversationId}", cancelToken: cancelToken)
        .map<GetOrderMessageByConversationResponse>(onMap: (value) => value.wrapResponse().mapFromResponseToGetOrderMessageByConversationResponse());
    });
  }

  @override
  FutureProcessing<GetOrderMessageByUserResponse> getOrderMessageByUser(GetOrderMessageByUserParameter getOrderMessageByUserParameter) {
    return DioHttpClientProcessing((cancelToken) {
      return dio.get("/chat-order/user", cancelToken: cancelToken)
        .map<GetOrderMessageByUserResponse>(onMap: (value) => value.wrapResponse().mapFromResponseToGetOrderMessageByUserResponse());
    });
  }

  @override
  FutureProcessing<CreateProductConversationResponse> createProductConversation(CreateProductConversationParameter createProductConversationParameter) {
    FormData formData = FormData.fromMap(
      <String, dynamic> {
        "message": createProductConversationParameter.message,
        "product_id": createProductConversationParameter.productId
      }
    );
    return DioHttpClientProcessing((cancelToken) {
      return dio.post("/chat-product", data: formData, cancelToken: cancelToken, options: OptionsBuilder.multipartData().build())
        .map<CreateProductConversationResponse>(onMap: (value) => value.wrapResponse().mapFromResponseToCreateProductConversationResponse());
    });
  }

  @override
  FutureProcessing<UpdateReadStatusProductConversationResponse> updateReadStatusProductConversation(UpdateReadStatusProductConversationParameter updateReadStatusProductConversationParameter) {
    return DioHttpClientProcessing((cancelToken) {
      return dio.post("/chat-help/update-status/${updateReadStatusProductConversationParameter.productConversationId}", cancelToken: cancelToken, options: OptionsBuilder.multipartData().build())
        .map<UpdateReadStatusProductConversationResponse>(onMap: (value) => value.wrapResponse().mapFromResponseToUpdateReadStatusProductConversationResponse());
    });
  }

  @override
  FutureProcessing<AnswerProductConversationResponse> answerProductConversation(AnswerProductConversationParameter answerProductConversationParameter) {
    FormData formData = FormData.fromMap(
      <String, dynamic> {
        "message": answerProductConversationParameter.message
      }
    );
    return DioHttpClientProcessing((cancelToken) {
      return dio.post("/chat-product/${answerProductConversationParameter.productConversationId}/message", data: formData, cancelToken: cancelToken, options: OptionsBuilder.multipartData().build())
        .map<AnswerProductConversationResponse>(onMap: (value) => value.wrapResponse().mapFromResponseToAnswerProductConversationResponse());
    });
  }

  @override
  FutureProcessing<GetProductMessageByConversationResponse> getProductMessageByConversation(GetProductMessageByConversationParameter getProductMessageByConversationParameter) {
    return DioHttpClientProcessing((cancelToken) {
      return dio.get("/chat-product/message/${getProductMessageByConversationParameter.productConversationId}", cancelToken: cancelToken)
        .map<GetProductMessageByConversationResponse>(onMap: (value) => value.wrapResponse().mapFromResponseToGetProductMessageByConversationResponse());
    });
  }

  @override
  FutureProcessing<GetProductMessageByUserResponse> getProductMessageByUser(GetProductMessageByUserParameter getProductMessageByUserParameter) {
    return DioHttpClientProcessing((cancelToken) {
      return dio.get("/chat-product/user", cancelToken: cancelToken)
        .map<GetProductMessageByUserResponse>(onMap: (value) => value.wrapResponse().mapFromResponseToGetProductMessageByUserResponse());
    });
  }

  @override
  FutureProcessing<GetProductMessageByProductResponse> getProductMessageByProduct(GetProductMessageByProductParameter getProductMessageByUserParameter) {
    return DioHttpClientProcessing((cancelToken) {
      return dio.get("/chat-product/product/${getProductMessageByUserParameter.productId}", cancelToken: cancelToken)
        .map<GetProductMessageByProductResponse>(onMap: (value) => value.wrapResponse().mapFromResponseToGetProductMessageByProductResponse());
    });
  }
}