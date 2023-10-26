import '../controllerstate/listitemcontrollerstate/list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/padding_container_list_item_controller_state.dart';
import '../itemtypelistinterceptor/itemtypelistinterceptorchecker/list_item_controller_state_item_type_list_interceptor_checker.dart';
import 'item_type_list_sub_interceptor.dart';

class PaddingContainerItemTypeListSubInterceptor extends ItemTypeListSubInterceptor<ListItemControllerState> {
  ListItemControllerStateItemTypeInterceptorChecker listItemControllerStateItemTypeInterceptorChecker;

  PaddingContainerItemTypeListSubInterceptor({
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
    List<ListItemControllerState> newPaddingChildListItemControllerState = [];
    if (oldItemType is PaddingContainerListItemControllerState) {
      ListItemControllerState paddingChildListItemControllerState = oldItemType.paddingChildListItemControllerState;
      listItemControllerStateItemTypeInterceptorChecker.interceptEachListItem(
        i, ListItemControllerStateWrapper(paddingChildListItemControllerState), oldItemTypeList, newPaddingChildListItemControllerState
      );
      if (newPaddingChildListItemControllerState.isNotEmpty) {
        int j = 0;
        while (j < newPaddingChildListItemControllerState.length) {
          newItemTypeList.add(
            PaddingContainerListItemControllerState(
              padding: oldItemType.padding,
              paddingChildListItemControllerState: newPaddingChildListItemControllerState[j]
            )
          );
          j++;
        }
      }
      return true;
    }
    return false;
  }
}