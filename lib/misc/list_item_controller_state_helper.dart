import 'controllerstate/listitemcontrollerstate/list_item_controller_state.dart';
import 'controllerstate/listitemcontrollerstate/no_content_list_item_controller_state.dart';
import 'controllerstate/listitemcontrollerstate/page_keyed_list_item_controller_state.dart';

class _ListItemControllerStateHelperImpl {
  bool checkListItemControllerStateList(List<ListItemControllerState>? listItemControllerStateList) {
    if (listItemControllerStateList != null) {
      if (listItemControllerStateList.isNotEmpty) {
        return true;
      }
    }
    return false;
  }

  ListItemControllerState parsePageKeyedListItemControllerState(ListItemControllerState oldListItemControllerState) {
    ListItemControllerState newListItemControllerState = NoContentListItemControllerState();
    if (oldListItemControllerState is PageKeyedListItemControllerState) {
      if (oldListItemControllerState.listItemControllerState != null) {
        newListItemControllerState = oldListItemControllerState.listItemControllerState!;
      }
    }
    return newListItemControllerState;
  }
}

// ignore: non_constant_identifier_names
var ListItemControllerStateHelper = _ListItemControllerStateHelperImpl();