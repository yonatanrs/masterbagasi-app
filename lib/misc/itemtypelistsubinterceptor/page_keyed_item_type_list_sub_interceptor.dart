import '../controllerstate/listitemcontrollerstate/list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/page_keyed_list_item_controller_state.dart';
import 'item_type_list_sub_interceptor.dart';

class PageKeyedItemTypeListSubInterceptor extends ItemTypeListSubInterceptor<ListItemControllerState> {
  @override
  bool intercept(
    int i,
    ListItemControllerStateWrapper oldItemTypeWrapper,
    List<ListItemControllerState> oldItemTypeList,
    List<ListItemControllerState> newItemTypeList
  ) {
    ListItemControllerState oldItemType = oldItemTypeWrapper.listItemControllerState;
    if (oldItemType is PageKeyedListItemControllerState) {
      oldItemTypeWrapper.listItemControllerState = oldItemType.listItemControllerState ?? oldItemType;
    }
    return false;
  }
}