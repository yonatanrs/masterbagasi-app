import 'package:flutter/cupertino.dart';

import '../controllerstate/listitemcontrollerstate/list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/padding_container_list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/productbundlelistitemcontrollerstate/vertical_product_bundle_list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/virtual_spacing_list_item_controller_state.dart';
import '../typedef.dart';
import 'item_type_list_sub_interceptor.dart';

class ProductBundleItemTypeListSubInterceptor extends ItemTypeListSubInterceptor<ListItemControllerState> {
  final DoubleReturned padding;
  final DoubleReturned itemSpacing;

  ProductBundleItemTypeListSubInterceptor({
    required this.padding,
    required this.itemSpacing
  });

  @override
  bool intercept(
    int i,
    ListItemControllerStateWrapper oldItemTypeWrapper,
    List<ListItemControllerState> oldItemTypeList,
    List<ListItemControllerState> newItemTypeList
  ) {
    ListItemControllerState oldItemType = oldItemTypeWrapper.listItemControllerState;
    if (oldItemType is VerticalProductBundleListItemControllerState) {
      newItemTypeList.addAll(<ListItemControllerState>[
        VirtualSpacingListItemControllerState(height: padding()),
        PaddingContainerListItemControllerState(
          padding: EdgeInsets.symmetric(horizontal: padding()),
          paddingChildListItemControllerState: VerticalProductBundleListItemControllerState(
            productBundle: oldItemType.productBundle,
            onAddWishlist: oldItemType.onAddWishlist,
            onRemoveWishlist: oldItemType.onRemoveWishlist,
            onAddCart: oldItemType.onAddCart,
            onRemoveCart: oldItemType.onRemoveCart
          )
        ),
      ]);
      if (i == oldItemTypeList.length - 1) {
        newItemTypeList.add(
          VirtualSpacingListItemControllerState(height: padding()),
        );
      }
      return true;
    }
    return false;
  }
}