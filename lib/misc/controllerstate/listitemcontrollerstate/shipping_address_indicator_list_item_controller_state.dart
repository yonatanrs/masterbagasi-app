import '../../../domain/entity/address/address.dart';
import 'list_item_controller_state.dart';

class ShippingAddressIndicatorListItemControllerState extends ListItemControllerState {
  Address shippingAddress;

  ShippingAddressIndicatorListItemControllerState({
    required this.shippingAddress
  });
}