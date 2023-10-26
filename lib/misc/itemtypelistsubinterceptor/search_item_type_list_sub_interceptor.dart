import 'package:get/get.dart';
import 'package:masterbagasi/domain/entity/wishlist/wishlist.dart';

import '../../domain/entity/product/product_appearance_data.dart';
import '../../domain/entity/product/productbundle/product_bundle.dart';
import '../../domain/entity/wishlist/support_wishlist.dart';
import '../controllerstate/listitemcontrollerstate/list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/productbundlelistitemcontrollerstate/vertical_product_bundle_list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/productlistitemcontrollerstate/vertical_product_list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/searchlistitemcontrollerstate/search_container_list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/title_and_description_list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/wishlistlistitemcontrollerstate/wishlist_container_list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/wishlistlistitemcontrollerstate/wishlist_list_item_controller_state.dart';
import '../error/message_error.dart';
import '../itemtypelistinterceptor/itemtypelistinterceptorchecker/list_item_controller_state_item_type_list_interceptor_checker.dart';
import '../listitemcontrollerstatewrapperparameter/has_intercept_child_list_item_controller_state_wrapper_parameter.dart';
import '../listitemcontrollerstatewrapperparameter/list_item_controller_state_wrapper_parameter.dart';
import '../typedef.dart';
import 'item_type_list_sub_interceptor.dart';
import 'verticalgriditemtypelistsubinterceptor/vertical_grid_item_type_list_sub_interceptor.dart';

class SearchItemTypeListSubInterceptor extends ItemTypeListSubInterceptor<ListItemControllerState> {
  final DoubleReturned padding;
  final DoubleReturned itemSpacing;
  final ListItemControllerStateItemTypeInterceptorChecker listItemControllerStateItemTypeInterceptorChecker;

  SearchItemTypeListSubInterceptor({
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
    if (oldItemType is SearchContainerListItemControllerState) {
      List<ListItemControllerState> newListItemControllerStateList = [];
      List<ListItemControllerState> wishlistListItemControllerStateList = oldItemType.productEntryList.map<ListItemControllerState>(
        (productEntry) {
          ListItemControllerState? currentListItemControllerState = VerticalProductListItemControllerState(
            productAppearanceData: productEntry,
            onRemoveWishlist: (productAppearanceData) => oldItemType.onRemoveWishlistWithProductAppearanceData(productAppearanceData),
            onAddWishlist: (productAppearanceData) => oldItemType.onAddWishlistWithProductAppearanceData(productAppearanceData),
            onAddCart: oldItemType.onAddProductCart,
          );
          return currentListItemControllerState;
        }
      ).toList();
      VerticalGridPaddingContentSubInterceptorSupportListItemControllerState verticalGridPaddingContentSubInterceptorSupportListItemControllerState = VerticalGridPaddingContentSubInterceptorSupportListItemControllerState(
        childListItemControllerStateList: wishlistListItemControllerStateList
      );
      listItemControllerStateItemTypeInterceptorChecker.interceptEachListItem(
        i,
        ListItemControllerStateWrapper(verticalGridPaddingContentSubInterceptorSupportListItemControllerState),
        oldItemTypeList,
        newListItemControllerStateList
      );
      newItemTypeList.addAll(newListItemControllerStateList);
      return true;
    }
    return false;
  }
}