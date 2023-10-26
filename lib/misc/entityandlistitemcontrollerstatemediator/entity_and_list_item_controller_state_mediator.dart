import '../controllerstate/listitemcontrollerstate/list_item_controller_state.dart';

abstract class EntityAndListItemControllerStateMediator {
  ListItemControllerState map(dynamic entity);
}