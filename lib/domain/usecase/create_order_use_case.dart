import '../../misc/load_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../entity/order/create_order_parameter.dart';
import '../entity/order/order.dart';
import '../repository/order_repository.dart';

class CreateOrderUseCase {
  final OrderRepository orderRepository;

  const CreateOrderUseCase({
    required this.orderRepository
  });

  FutureProcessing<LoadDataResult<Order>> execute(CreateOrderParameter createOrderParameter) {
    return orderRepository.createOrder(createOrderParameter);
  }
}