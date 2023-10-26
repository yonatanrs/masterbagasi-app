import 'base_order_list_item_controller_state.dart';

class WaitingForPaymentOrderListItemControllerState extends BaseOrderListItemControllerState {
  int waitingForPaymentOrderCount;
  void Function()? onTap;

  WaitingForPaymentOrderListItemControllerState({
    required this.waitingForPaymentOrderCount,
    this.onTap
  });
}