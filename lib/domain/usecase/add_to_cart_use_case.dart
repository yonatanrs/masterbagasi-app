import '../../misc/load_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../entity/cart/add_to_cart_parameter.dart';
import '../entity/cart/add_to_cart_response.dart';
import '../repository/cart_repository.dart';

class AddToCartUseCase {
  final CartRepository cartRepository;

  const AddToCartUseCase({
    required this.cartRepository
  });

  FutureProcessing<LoadDataResult<AddToCartResponse>> execute(AddToCartParameter addToCartParameter) {
    return cartRepository.addToCart(addToCartParameter);
  }
}