import '../../misc/load_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../entity/cart/add_host_cart_parameter.dart';
import '../entity/cart/add_host_cart_response.dart';
import '../repository/cart_repository.dart';

class AddHostCartUseCase {
  final CartRepository cartRepository;

  const AddHostCartUseCase({
    required this.cartRepository
  });

  FutureProcessing<LoadDataResult<AddHostCartResponse>> execute(AddHostCartParameter addHostCartParameter) {
    return cartRepository.addHostCart(addHostCartParameter);
  }
}