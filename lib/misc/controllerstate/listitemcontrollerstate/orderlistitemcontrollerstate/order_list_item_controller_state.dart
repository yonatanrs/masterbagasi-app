import '../../../../domain/entity/order/combined_order.dart';
import 'base_order_list_item_controller_state.dart';

abstract class OrderListItemControllerState extends BaseOrderListItemControllerState {
  CombinedOrder order;

  OrderListItemControllerState({
    required this.order
  });
}