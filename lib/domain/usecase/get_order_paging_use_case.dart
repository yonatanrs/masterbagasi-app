import '../../misc/load_data_result.dart';
import '../../misc/paging/pagingresult/paging_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../entity/order/combined_order.dart';
import '../entity/order/order_paging_parameter.dart';
import '../repository/order_repository.dart';

class GetOrderPagingUseCase {
  final OrderRepository orderRepository;

  const GetOrderPagingUseCase({
    required this.orderRepository
  });

  FutureProcessing<LoadDataResult<PagingDataResult<CombinedOrder>>> execute(OrderPagingParameter orderPagingParameter) {
    return orderRepository.orderPaging(orderPagingParameter);
  }
}