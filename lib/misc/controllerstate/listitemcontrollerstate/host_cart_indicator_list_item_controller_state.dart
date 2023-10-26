import '../../../domain/entity/cart/host_cart.dart';
import 'list_item_controller_state.dart';

class HostCartIndicatorListItemControllerState extends ListItemControllerState {
  final HostCart hostCart;

  HostCartIndicatorListItemControllerState({
    required this.hostCart
  });
}