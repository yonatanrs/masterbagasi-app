import '../controllerstate/listitemcontrollerstate/list_item_controller_state.dart';
import '../itemtypelistinterceptor/item_type_list_interceptor_parameter.dart';

abstract class BaseItemTypeListSubInterceptor<ItemType> {
  void onInit(List<ItemType> oldItemTypeList, List<ItemType> newItemTypeList) {}
}

abstract class ItemTypeListSubInterceptor<ItemType> extends BaseItemTypeListSubInterceptor<ItemType> {
  bool intercept(
    int i,
    ListItemControllerStateWrapper oldItemTypeWrapper,
    List<ItemType> oldItemTypeList,
    List<ItemType> newItemTypeList
  );
}

abstract class ParameterizedItemTypeListSubInterceptor<ItemType> extends BaseItemTypeListSubInterceptor<ItemType> {
  bool interceptWithParameter(
    int i,
    ListItemControllerStateWrapper oldItemTypeWrapper,
    List<ItemType> oldItemTypeList,
    List<ItemType> newItemTypeList,
    ItemTypeListInterceptorParameter itemTypeListInterceptorParameter
  );
}