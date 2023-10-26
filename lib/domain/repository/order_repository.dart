import '../../misc/load_data_result.dart';
import '../../misc/paging/pagingresult/paging_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../entity/order/combined_order.dart';
import '../entity/order/create_order_parameter.dart';
import '../entity/order/order.dart';
import '../entity/order/order_based_id_parameter.dart';
import '../entity/order/order_paging_parameter.dart';

abstract class OrderRepository {
  FutureProcessing<LoadDataResult<Order>> createOrder(CreateOrderParameter createOrderParameter);
  FutureProcessing<LoadDataResult<PagingDataResult<CombinedOrder>>> orderPaging(OrderPagingParameter orderPagingParameter);
  FutureProcessing<LoadDataResult<Order>> orderBasedId(OrderBasedIdParameter orderBasedIdParameter);
}