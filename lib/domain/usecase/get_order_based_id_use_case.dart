import '../../misc/load_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../entity/order/combined_order.dart';
import '../entity/order/order.dart';
import '../entity/order/order_based_id_parameter.dart';
import '../repository/order_repository.dart';

class GetOrderBasedIdUseCase {
  final OrderRepository orderRepository;

  const GetOrderBasedIdUseCase({
    required this.orderRepository
  });

  FutureProcessing<LoadDataResult<Order>> execute(OrderBasedIdParameter orderBasedIdParameter) {
    return orderRepository.orderBasedId(orderBasedIdParameter);
  }
}