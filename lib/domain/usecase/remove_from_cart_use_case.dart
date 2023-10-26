import '../../misc/load_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../entity/cart/remove_from_cart_parameter.dart';
import '../entity/cart/remove_from_cart_response.dart';
import '../repository/cart_repository.dart';

class RemoveFromCartUseCase {
  final CartRepository cartRepository;

  const RemoveFromCartUseCase({
    required this.cartRepository
  });

  FutureProcessing<LoadDataResult<RemoveFromCartResponse>> execute(RemoveFromCartParameter removeFromCartParameter) {
    return cartRepository.removeFromCart(removeFromCartParameter);
  }
}