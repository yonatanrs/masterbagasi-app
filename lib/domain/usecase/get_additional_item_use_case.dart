import '../../misc/load_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../entity/additionalitem/additional_item.dart';
import '../entity/additionalitem/additional_item_list_parameter.dart';
import '../repository/cart_repository.dart';

class GetAdditionalItemUseCase {
  final CartRepository cartRepository;

  const GetAdditionalItemUseCase({
    required this.cartRepository
  });

  FutureProcessing<LoadDataResult<List<AdditionalItem>>> execute(AdditionalItemListParameter additionalItemListParameter) {
    return cartRepository.additionalItemList(additionalItemListParameter);
  }
}