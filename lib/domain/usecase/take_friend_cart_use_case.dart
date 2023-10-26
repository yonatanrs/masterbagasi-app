import '../../misc/load_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../entity/cart/take_friend_cart_parameter.dart';
import '../entity/cart/take_friend_cart_response.dart';
import '../repository/cart_repository.dart';

class TakeFriendCartUseCase {
  final CartRepository cartRepository;

  const TakeFriendCartUseCase({
    required this.cartRepository
  });

  FutureProcessing<LoadDataResult<TakeFriendCartResponse>> execute(TakeFriendCartParameter takeFriendCartParameter) {
    return cartRepository.takeFriendCart(takeFriendCartParameter);
  }
}