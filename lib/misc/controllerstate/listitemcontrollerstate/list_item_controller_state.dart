import '../../listitemcontrollerstatewrapperparameter/list_item_controller_state_wrapper_parameter.dart';

abstract class ListItemControllerState {}

class ListItemControllerStateWrapper {
  ListItemControllerState listItemControllerState;

  ListItemControllerStateWrapper(
    this.listItemControllerState
  );
}

class ParameterizedListItemControllerStateWrapper extends ListItemControllerStateWrapper {
  ListItemControllerStateWrapperParameter listItemControllerStateWrapperParameter;

  ParameterizedListItemControllerStateWrapper(
    ListItemControllerState listItemControllerState,
    this.listItemControllerStateWrapperParameter
  ) : super(
    listItemControllerState
  );
}