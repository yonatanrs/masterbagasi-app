import '../../../../domain/entity/order/order.dart';
import '../list_item_controller_state.dart';

class OrderDetailContainerListItemControllerState extends ListItemControllerState {
  Order order;
  void Function() onUpdateState;

  OrderDetailContainerListItemControllerState({
    required this.order,
    required this.onUpdateState
  });
}