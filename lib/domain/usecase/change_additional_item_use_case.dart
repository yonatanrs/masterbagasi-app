import '../../misc/load_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../entity/additionalitem/change_additional_item_parameter.dart';
import '../entity/additionalitem/change_additional_item_response.dart';
import '../repository/cart_repository.dart';

class ChangeAdditionalItemUseCase {
  final CartRepository cartRepository;

  const ChangeAdditionalItemUseCase({
    required this.cartRepository
  });

  FutureProcessing<LoadDataResult<ChangeAdditionalItemResponse>> execute(ChangeAdditionalItemParameter changeAdditionalItemParameter) {
    return cartRepository.changeAdditionalItem(changeAdditionalItemParameter);
  }
}