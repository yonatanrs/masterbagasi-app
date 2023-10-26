import '../../misc/load_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../entity/chat/order/get_order_message_by_user_parameter.dart';
import '../entity/chat/order/get_order_message_by_user_response.dart';
import '../repository/chat_repository.dart';

class GetOrderMessageByUserUseCase {
  final ChatRepository chatRepository;

  const GetOrderMessageByUserUseCase({
    required this.chatRepository
  });

  FutureProcessing<LoadDataResult<GetOrderMessageByUserResponse>> execute(GetOrderMessageByUserParameter getOrderMessageByUserParameter) {
    return chatRepository.getOrderMessageByUser(getOrderMessageByUserParameter);
  }
}