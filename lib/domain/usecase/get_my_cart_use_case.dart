import '../../misc/load_data_result.dart';
import '../../misc/paging/pagingresult/paging_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../entity/cart/cart.dart';
import '../entity/cart/cart_paging_parameter.dart';
import '../repository/cart_repository.dart';

class GetMyCartUseCase {
  final CartRepository cartRepository;

  const GetMyCartUseCase({
    required this.cartRepository
  });

  FutureProcessing<LoadDataResult<PagingDataResult<Cart>>> execute(CartPagingParameter cartPagingParameter) {
    return cartRepository.cartPaging(cartPagingParameter);
  }
}