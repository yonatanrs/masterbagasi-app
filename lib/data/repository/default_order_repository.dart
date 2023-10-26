import '../../domain/entity/order/combined_order.dart';
import '../../domain/entity/order/create_order_parameter.dart';
import '../../domain/entity/order/order.dart';
import '../../domain/entity/order/order_based_id_parameter.dart';
import '../../domain/entity/order/order_paging_parameter.dart';
import '../../domain/repository/order_repository.dart';
import '../../misc/load_data_result.dart';
import '../../misc/paging/pagingresult/paging_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../datasource/orderdatasource/order_data_source.dart';

class DefaultOrderRepository implements OrderRepository {
  final OrderDataSource orderDataSource;

  const DefaultOrderRepository({
    required this.orderDataSource
  });

  @override
  FutureProcessing<LoadDataResult<Order>> createOrder(CreateOrderParameter createOrderParameter) {
    return orderDataSource.createOrder(createOrderParameter).mapToLoadDataResult<Order>();
  }

  @override
  FutureProcessing<LoadDataResult<PagingDataResult<CombinedOrder>>> orderPaging(OrderPagingParameter orderPagingParameter) {
    return orderDataSource.orderPaging(orderPagingParameter).mapToLoadDataResult<PagingDataResult<CombinedOrder>>();
  }

  @override
  FutureProcessing<LoadDataResult<Order>> orderBasedId(OrderBasedIdParameter orderBasedIdParameter) {
    return orderDataSource.orderBasedId(orderBasedIdParameter).mapToLoadDataResult<Order>();
  }
}