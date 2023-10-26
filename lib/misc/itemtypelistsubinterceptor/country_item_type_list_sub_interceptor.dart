import 'package:collection/collection.dart';

import '../controllerstate/listitemcontrollerstate/list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/selectcountrieslistitemcontrollerstate/country_container_list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/selectcountrieslistitemcontrollerstate/vertical_country_list_item_controller_state.dart';
import '../itemtypelistinterceptor/itemtypelistinterceptorchecker/list_item_controller_state_item_type_list_interceptor_checker.dart';
import '../typedef.dart';
import 'item_type_list_sub_interceptor.dart';

class CountryItemTypeListSubInterceptor extends ItemTypeListSubInterceptor<ListItemControllerState> {
  final DoubleReturned padding;
  final DoubleReturned itemSpacing;
  final ListItemControllerStateItemTypeInterceptorChecker listItemControllerStateItemTypeInterceptorChecker;

  CountryItemTypeListSubInterceptor({
    required this.padding,
    required this.itemSpacing,
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
    if (oldItemType is CountryContainerListItemControllerState) {
      List<ListItemControllerState> resultListItemControllerStateList = oldItemType.country.mapIndexed<ListItemControllerState>(
        (index, country) => VerticalCountryListItemControllerState(
          country: country,
          isSelected: oldItemType.onGetSelectCountry!()?.id == country.id,
          onSelectCountry: (country) {
            if (oldItemType.onSelectCountry != null) {
              oldItemType.onSelectCountry!(country);
            }
          },
        )
      ).toList();
      for (var listItemControllerState in resultListItemControllerStateList) {
        listItemControllerStateItemTypeInterceptorChecker.interceptEachListItem(
          i, ListItemControllerStateWrapper(listItemControllerState), oldItemTypeList, newItemTypeList
        );
      }
      return true;
    }
    return false;
  }
}