import '../../../../domain/entity/address/address.dart';
import '../../../../presentation/widget/address/address_item.dart';
import '../list_item_controller_state.dart';

abstract class AddressListItemControllerState extends ListItemControllerState {
  Address address;
  OnSelectAddress? onSelectAddress;
  OnRemoveAddress? onRemoveAddress;

  AddressListItemControllerState({
    required this.address,
    this.onSelectAddress,
    this.onRemoveAddress
  });
}