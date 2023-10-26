import '../../misc/load_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../entity/cart/cart_summary.dart';
import '../entity/cart/cart_summary_parameter.dart';
import '../repository/cart_repository.dart';

class GetCartSummaryUseCase {
  final CartRepository cartRepository;

  const GetCartSummaryUseCase({
    required this.cartRepository
  });

  FutureProcessing<LoadDataResult<CartSummary>> execute(CartSummaryParameter cartSummaryParameter) {
    return cartRepository.cartSummary(cartSummaryParameter);
  }
}