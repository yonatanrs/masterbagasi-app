import '../../misc/load_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../entity/chat/product/get_product_message_by_product_parameter.dart';
import '../entity/chat/product/get_product_message_by_product_response.dart';
import '../repository/chat_repository.dart';

class GetProductMessageByProductUseCase {
  final ChatRepository chatRepository;

  const GetProductMessageByProductUseCase({
    required this.chatRepository
  });

  FutureProcessing<LoadDataResult<GetProductMessageByProductResponse>> execute(GetProductMessageByProductParameter getProductMessageByProductParameter) {
    return chatRepository.getProductMessageByProduct(getProductMessageByProductParameter);
  }
}