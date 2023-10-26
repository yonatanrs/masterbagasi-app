import '../../../domain/entity/address/address.dart';
import '../../errorprovider/error_provider.dart';
import '../../load_data_result.dart';
import 'list_item_controller_state.dart';

class DeliveryToListItemControllerState extends ListItemControllerState {
  LoadDataResult<Address> addressLoadDataResult;
  ErrorProvider errorProvider;
  void Function(Address)? onAddressSelectedChanged;

  DeliveryToListItemControllerState({
    required this.addressLoadDataResult,
    required this.errorProvider,
    this.onAddressSelectedChanged
  });
}