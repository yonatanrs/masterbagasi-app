import '../controllerstate/listitemcontrollerstate/column_container_list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/decorated_container_list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/list_item_controller_state.dart';
import '../itemtypelistinterceptor/itemtypelistinterceptorchecker/list_item_controller_state_item_type_list_interceptor_checker.dart';
import 'item_type_list_sub_interceptor.dart';

class DecoratedContainerItemTypeListSubInterceptor extends ItemTypeListSubInterceptor<ListItemControllerState> {
  ListItemControllerStateItemTypeInterceptorChecker listItemControllerStateItemTypeInterceptorChecker;

  DecoratedContainerItemTypeListSubInterceptor({
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
    List<ListItemControllerState> newChildListItemControllerState = [];
    if (oldItemType is DecoratedContainerListItemControllerState) {
      ListItemControllerState decoratedChildListItemControllerState = oldItemType.decoratedChildListItemControllerState;
      listItemControllerStateItemTypeInterceptorChecker.interceptEachListItem(
        i, ListItemControllerStateWrapper(decoratedChildListItemControllerState), oldItemTypeList, newChildListItemControllerState
      );
      newItemTypeList.add(
        DecoratedContainerListItemControllerState(
          padding: oldItemType.padding,
          decoration: oldItemType.decoration,
          decoratedChildListItemControllerState: ColumnContainerListItemControllerState(
            columnChildListItemControllerState: newChildListItemControllerState
          )
        )
      );
      return true;
    }
    return false;
  }
}