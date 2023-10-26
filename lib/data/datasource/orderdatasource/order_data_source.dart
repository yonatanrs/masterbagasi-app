import '../../../domain/entity/order/combined_order.dart';
import '../../../domain/entity/order/create_order_parameter.dart';
import '../../../domain/entity/order/order.dart';
import '../../../domain/entity/order/order_based_id_parameter.dart';
import '../../../domain/entity/order/order_paging_parameter.dart';
import '../../../misc/load_data_result.dart';
import '../../../misc/paging/pagingresult/paging_data_result.dart';
import '../../../misc/processing/future_processing.dart';

abstract class OrderDataSource {
  FutureProcessing<Order> createOrder(CreateOrderParameter createOrderParameter);
  FutureProcessing<PagingDataResult<CombinedOrder>> orderPaging(OrderPagingParameter orderPagingParameter);
  FutureProcessing<Order> orderBasedId(OrderBasedIdParameter orderBasedIdParameter);
}