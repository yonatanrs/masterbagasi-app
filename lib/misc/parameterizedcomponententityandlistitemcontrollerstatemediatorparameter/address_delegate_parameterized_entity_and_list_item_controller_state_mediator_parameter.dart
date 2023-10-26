import '../../domain/entity/address/address.dart';
import 'parameterized_entity_and_list_item_controller_state_mediator_parameter.dart';

typedef OnSelectAddressFromDelegate = void Function(Address, void Function());
typedef OnGetSelectedAddressFromDelegate = Address? Function();

class AddressDelegateParameterizedEntityAndListItemControllerStateMediatorParameter extends ParameterizedEntityAndListItemControllerStateMediatorParameter {
  OnSelectAddressFromDelegate? onSelectAddressFromDelegate;

  AddressDelegateParameterizedEntityAndListItemControllerStateMediatorParameter({
    this.onSelectAddressFromDelegate
  });
}