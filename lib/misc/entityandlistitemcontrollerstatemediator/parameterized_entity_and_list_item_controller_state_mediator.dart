import '../controllerstate/listitemcontrollerstate/list_item_controller_state.dart';

abstract class ParameterizedEntityAndListItemControllerStateMediator {
  ListItemControllerState mapWithParameter(entity, {parameter});
}