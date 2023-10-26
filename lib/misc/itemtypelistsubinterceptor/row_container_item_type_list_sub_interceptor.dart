import '../controllerstate/listitemcontrollerstate/list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/row_container_list_item_controller_state.dart';
import '../itemtypelistinterceptor/itemtypelistinterceptorchecker/list_item_controller_state_item_type_list_interceptor_checker.dart';
import 'item_type_list_sub_interceptor.dart';

class RowContainerItemTypeListSubInterceptor extends ItemTypeListSubInterceptor<ListItemControllerState> {
  ListItemControllerStateItemTypeInterceptorChecker listItemControllerStateItemTypeInterceptorChecker;

  RowContainerItemTypeListSubInterceptor({
    required this.listItemControllerStateItemTypeInterceptorChecker
  });

  @override
  bool intercept(
    int i,
    ListItemControllerStateWrapper oldItemTypeWrapper,
    List<ListItemControllerState> oldItemTypeList,
    List<ListItemControllerState> newItemTypeList
  ) {
    ListItemControllerState oldItemType = oldItemTypeWrapper.listItemControllerState;
    if (oldItemType is RowContainerListItemControllerState) {
      int j = 0;
      List<ListItemControllerState> rowChildListItemControllerState = oldItemType.rowChildListItemControllerState;
      List<ListItemControllerState> newRowChildListItemControllerState = [];
      while (j < newRowChildListItemControllerState.length) {
        ListItemControllerState listItemControllerState = rowChildListItemControllerState[j];
        listItemControllerStateItemTypeInterceptorChecker.interceptEachListItem(
          i, ListItemControllerStateWrapper(listItemControllerState), oldItemTypeList, newRowChildListItemControllerState
        );
        j++;
      }
      newItemTypeList.add(
        RowContainerListItemControllerState(
          padding: oldItemType.padding,
          rowChildListItemControllerState: rowChildListItemControllerState
        )
      );
      return true;
    }
    return false;
  }
}