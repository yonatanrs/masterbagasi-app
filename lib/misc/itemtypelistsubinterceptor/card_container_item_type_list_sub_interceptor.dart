import '../controllerstate/listitemcontrollerstate/card_container_list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/column_container_list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/decorated_container_list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/list_item_controller_state.dart';
import '../itemtypelistinterceptor/itemtypelistinterceptorchecker/list_item_controller_state_item_type_list_interceptor_checker.dart';
import 'item_type_list_sub_interceptor.dart';

class CardContainerItemTypeListSubInterceptor extends ItemTypeListSubInterceptor<ListItemControllerState> {
  ListItemControllerStateItemTypeInterceptorChecker listItemControllerStateItemTypeInterceptorChecker;

  CardContainerItemTypeListSubInterceptor({
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
    if (oldItemType is CardContainerListItemControllerState) {
      ListItemControllerState cardContainerChildListItemControllerState = oldItemType.cardContainerChildListItemControllerState;
      listItemControllerStateItemTypeInterceptorChecker.interceptEachListItem(
        i, ListItemControllerStateWrapper(cardContainerChildListItemControllerState), oldItemTypeList, newChildListItemControllerState
      );
      newItemTypeList.add(
        CardContainerListItemControllerState(
          borderRadius: oldItemType.borderRadius,
          cardContainerChildListItemControllerState: ColumnContainerListItemControllerState(
            columnChildListItemControllerState: newChildListItemControllerState
          )
        )
      );
      return true;
    }
    return false;
  }
}