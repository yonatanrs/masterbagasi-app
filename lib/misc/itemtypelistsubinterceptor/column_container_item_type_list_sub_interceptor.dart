import '../controllerstate/listitemcontrollerstate/column_container_list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/list_item_controller_state.dart';
import '../itemtypelistinterceptor/itemtypelistinterceptorchecker/list_item_controller_state_item_type_list_interceptor_checker.dart';
import 'item_type_list_sub_interceptor.dart';

class ColumnContainerItemTypeListSubInterceptor extends ItemTypeListSubInterceptor<ListItemControllerState> {
  ListItemControllerStateItemTypeInterceptorChecker listItemControllerStateItemTypeInterceptorChecker;

  ColumnContainerItemTypeListSubInterceptor({
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
    if (oldItemType is ColumnContainerListItemControllerState) {
      int j = 0;
      List<ListItemControllerState> columnChildListItemControllerState = oldItemType.columnChildListItemControllerState;
      List<ListItemControllerState> newColumnChildListItemControllerState = [];
      while (j < columnChildListItemControllerState.length) {
        ListItemControllerState listItemControllerState = columnChildListItemControllerState[j];
        listItemControllerStateItemTypeInterceptorChecker.interceptEachListItem(
          i, ListItemControllerStateWrapper(listItemControllerState), oldItemTypeList, newColumnChildListItemControllerState
        );
        j++;
      }
      newItemTypeList.add(
        ColumnContainerListItemControllerState(
          padding: oldItemType.padding,
          columnChildListItemControllerState: newColumnChildListItemControllerState
        )
      );
      return true;
    }
    return false;
  }
}