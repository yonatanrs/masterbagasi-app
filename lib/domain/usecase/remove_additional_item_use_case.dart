import '../../misc/load_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../entity/additionalitem/remove_additional_item_parameter.dart';
import '../entity/additionalitem/remove_additional_item_response.dart';
import '../repository/cart_repository.dart';

class RemoveAdditionalItemUseCase {
  final CartRepository cartRepository;

  const RemoveAdditionalItemUseCase({
    required this.cartRepository
  });

  FutureProcessing<LoadDataResult<RemoveAdditionalItemResponse>> execute(RemoveAdditionalItemParameter removeAdditionalItemParameter) {
    return cartRepository.removeAdditionalItem(removeAdditionalItemParameter);
  }
}