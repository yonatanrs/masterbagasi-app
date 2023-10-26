import '../../misc/load_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../entity/additionalitem/add_additional_item_parameter.dart';
import '../entity/additionalitem/add_additional_item_response.dart';
import '../repository/cart_repository.dart';

class AddAdditionalItemUseCase {
  final CartRepository cartRepository;

  const AddAdditionalItemUseCase({
    required this.cartRepository
  });

  FutureProcessing<LoadDataResult<AddAdditionalItemResponse>> execute(AddAdditionalItemParameter addAdditionalItemParameter) {
    return cartRepository.addAdditionalItem(addAdditionalItemParameter);
  }
}