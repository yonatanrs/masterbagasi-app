import 'package:masterbagasi/presentation/widget/colorful_chip_tab_bar.dart';

import '../../../../domain/entity/order/combined_order.dart';
import '../list_item_controller_state.dart';

class OrderContainerListItemControllerState extends ListItemControllerState {
  List<CombinedOrder> orderList;
  void Function() onUpdateState;
  void Function(CombinedOrder) onOrderTap;
  void Function(CombinedOrder) onBuyAgainTap;
  ColorfulChipTabBarController orderTabColorfulChipTabBarController;
  List<ColorfulChipTabBarData> orderColorfulChipTabBarDataList;

  OrderContainerListItemControllerState({
    required this.orderList,
    required this.onUpdateState,
    required this.onOrderTap,
    required this.onBuyAgainTap,
    required this.orderTabColorfulChipTabBarController,
    required this.orderColorfulChipTabBarDataList
  });
}