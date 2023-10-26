import 'base_order_list_item_controller_state.dart';

class IsRunningOrderListItemControllerState extends BaseOrderListItemControllerState {
  int isRunningOrderCount;
  void Function()? onTap;

  IsRunningOrderListItemControllerState({
    required this.isRunningOrderCount,
    this.onTap
  });
}