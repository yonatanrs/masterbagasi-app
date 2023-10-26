import '../controllerstate/listitemcontrollerstate/additionalloadingindicatorlistitemcontrollerstate/additional_loading_indicator_list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/loading_list_item_controller_state.dart';
import '../itemtypelistinterceptor/item_type_list_interceptor_parameter.dart';
import '../itemtypelistinterceptor/itemtypelistinterceptorchecker/list_item_controller_state_item_type_list_interceptor_checker.dart';
import '../typedef.dart';
import 'item_type_list_sub_interceptor.dart';

class AdditionalLoadingIndicatorItemTypeListSubInterceptor extends ParameterizedItemTypeListSubInterceptor<ListItemControllerState> {
  final DoubleReturned padding;
  final DoubleReturned itemSpacing;
  final ListItemControllerStateItemTypeInterceptorChecker listItemControllerStateItemTypeInterceptorChecker;

  AdditionalLoadingIndicatorItemTypeListSubInterceptor({
    required this.padding,
    required this.itemSpacing,
    required this.listItemControllerStateItemTypeInterceptorChecker
  });

  @override
  bool interceptWithParameter(
    int i,
    ListItemControllerStateWrapper oldItemTypeWrapper,
    List<ListItemControllerState> oldItemTypeList,
    List<ListItemControllerState> newItemTypeList,
    ItemTypeListInterceptorParameter itemTypeListInterceptorParameter
  ) {
    ListItemControllerState oldItemType = oldItemTypeWrapper.listItemControllerState;
    if (oldItemType is AdditionalLoadingIndicatorListItemControllerState) {
      listItemControllerStateItemTypeInterceptorChecker.interceptEachListItem(
        i,
        ListItemControllerStateWrapper(LoadingListItemControllerState()),
        oldItemTypeList,
        newItemTypeList
      );
      return true;
    }
    return false;
  }
}