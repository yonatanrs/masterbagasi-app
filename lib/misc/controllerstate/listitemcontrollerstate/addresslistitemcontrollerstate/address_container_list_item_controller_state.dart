import '../../../../domain/entity/address/address.dart';
import '../../../../presentation/widget/address/address_item.dart';
import '../list_item_controller_state.dart';

class AddressContainerListItemControllerState extends ListItemControllerState {
  List<Address> address;
  OnSelectAddress? onSelectAddress;
  OnRemoveAddress? onRemoveAddress;
  void Function() onUpdateState;
  AddressContainerStorageListItemControllerState addressContainerStorageListItemControllerState;
  AddressContainerInterceptingActionListItemControllerState addressContainerInterceptingActionListItemControllerState;

  AddressContainerListItemControllerState({
    required this.address,
    this.onSelectAddress,
    this.onRemoveAddress,
    required this.onUpdateState,
    required this.addressContainerStorageListItemControllerState,
    required this.addressContainerInterceptingActionListItemControllerState
  });
}

abstract class AddressContainerStorageListItemControllerState extends ListItemControllerState {}

abstract class AddressContainerInterceptingActionListItemControllerState extends ListItemControllerState {
  void Function(Address)? get removeAddress;
}