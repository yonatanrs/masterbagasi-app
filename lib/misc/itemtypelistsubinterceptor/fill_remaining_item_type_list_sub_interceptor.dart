import '../controllerstate/listitemcontrollerstate/fill_remaining_list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/padding_container_list_item_controller_state.dart';
import '../itemtypelistinterceptor/itemtypelistinterceptorchecker/list_item_controller_state_item_type_list_interceptor_checker.dart';
import 'item_type_list_sub_interceptor.dart';

class FillRemainingItemTypeListSubInterceptor extends ItemTypeListSubInterceptor<ListItemControllerState> {
  ListItemControllerStateItemTypeInterceptorChecker listItemControllerStateItemTypeInterceptorChecker;

  FillRemainingItemTypeListSubInterceptor({
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
    if (oldItemType is FillRemainingListItemControllerState) {
      ListItemControllerState childListItemControllerState = oldItemType.childListItemControllerState;
      listItemControllerStateItemTypeInterceptorChecker.interceptEachListItem(
        i, ListItemControllerStateWrapper(childListItemControllerState), oldItemTypeList, newChildListItemControllerState
      );
      if (newChildListItemControllerState.isNotEmpty) {
        newItemTypeList.add(
          FillRemainingListItemControllerState(
            childListItemControllerState: newChildListItemControllerState[0]
          )
        );
      }
      return true;
    }
    return false;
  }
}