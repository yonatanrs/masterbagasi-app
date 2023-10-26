import '../../misc/load_data_result.dart';
import '../../misc/paging/pagingresult/paging_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../entity/cart/cart.dart';
import '../entity/cart/shared_cart_paging_parameter.dart';
import '../repository/cart_repository.dart';

class GetSharedCartUseCase {
  final CartRepository cartRepository;

  const GetSharedCartUseCase({
    required this.cartRepository
  });

  FutureProcessing<LoadDataResult<PagingDataResult<Cart>>> execute(SharedCartPagingParameter sharedCartPagingParameter) {
    return cartRepository.sharedCartPaging(sharedCartPagingParameter);
  }
}