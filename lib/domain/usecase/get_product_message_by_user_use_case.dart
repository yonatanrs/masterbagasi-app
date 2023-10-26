import '../../misc/load_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../entity/chat/product/get_product_message_by_user_parameter.dart';
import '../entity/chat/product/get_product_message_by_user_response.dart';
import '../repository/chat_repository.dart';

class GetProductMessageByUserUseCase {
  final ChatRepository chatRepository;

  const GetProductMessageByUserUseCase({
    required this.chatRepository
  });

  FutureProcessing<LoadDataResult<GetProductMessageByUserResponse>> execute(GetProductMessageByUserParameter getProductMessageByUserParameter) {
    return chatRepository.getProductMessageByUser(getProductMessageByUserParameter);
  }
}