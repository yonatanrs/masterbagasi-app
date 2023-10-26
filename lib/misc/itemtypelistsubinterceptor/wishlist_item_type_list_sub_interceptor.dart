import 'package:get/get.dart';
import 'package:masterbagasi/domain/entity/wishlist/wishlist.dart';

import '../../domain/entity/product/product_appearance_data.dart';
import '../../domain/entity/product/productbundle/product_bundle.dart';
import '../../domain/entity/wishlist/support_wishlist.dart';
import '../controllerstate/listitemcontrollerstate/list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/productbundlelistitemcontrollerstate/vertical_product_bundle_list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/productlistitemcontrollerstate/vertical_product_list_item_controller_state.dart';
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

class WishlistItemTypeListSubInterceptor extends ItemTypeListSubInterceptor<ListItemControllerState> {
  final DoubleReturned padding;
  final DoubleReturned itemSpacing;
  final ListItemControllerStateItemTypeInterceptorChecker listItemControllerStateItemTypeInterceptorChecker;

  WishlistItemTypeListSubInterceptor({
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
    if (oldItemType is WishlistListItemControllerState) {
      bool hasInterceptChild = true;
      if (oldItemTypeWrapper is ParameterizedListItemControllerStateWrapper) {
        ListItemControllerStateWrapperParameter listItemControllerStateWrapperParameter = oldItemTypeWrapper.listItemControllerStateWrapperParameter;
        if (listItemControllerStateWrapperParameter is HasInterceptChildListItemControllerStateWrapperParameter) {
          hasInterceptChild = listItemControllerStateWrapperParameter.interceptChild;
        }
      }
      List<ListItemControllerState> newListItemControllerStateList = [];
      ListItemControllerState childListItemControllerState = oldItemType.childListItemControllerState;
      if (hasInterceptChild) {
        listItemControllerStateItemTypeInterceptorChecker.interceptEachListItem(
          i, ListItemControllerStateWrapper(childListItemControllerState), oldItemTypeList, newListItemControllerStateList
        );
      } else {
        newListItemControllerStateList.add(childListItemControllerState);
      }
      newItemTypeList.addAll(newListItemControllerStateList);
      return true;
    } else if (oldItemType is WishlistContainerListItemControllerState) {
      List<ListItemControllerState> newListItemControllerStateList = [];
      var wishlistContainerInterceptingActionListItemControllerState = oldItemType.wishlistContainerInterceptingActionListItemControllerState;
      if (wishlistContainerInterceptingActionListItemControllerState is DefaultWishlistContainerInterceptingActionListItemControllerState) {
        wishlistContainerInterceptingActionListItemControllerState._removeWishlist = (wishlist) {
          int l = 0;
          while (l < oldItemType.wishlistList.length) {
            if (oldItemType.wishlistList[l].id == wishlist.id) {
              oldItemType.wishlistList.removeAt(l);
              break;
            }
            l++;
          }
          oldItemType.onUpdateState();
        };
      }
      List<ListItemControllerState> wishlistListItemControllerStateList = oldItemType.wishlistList.map<ListItemControllerState>(
        (wishlist) {
          SupportWishlist supportWishlist = wishlist.supportWishlist;
          ListItemControllerState? currentListItemControllerState;
          if (supportWishlist is ProductAppearanceData) {
            currentListItemControllerState = VerticalProductListItemControllerState(
              productAppearanceData: supportWishlist as ProductAppearanceData,
              onRemoveWishlist: (productAppearanceData) => oldItemType.onRemoveWishlistWithWishlist(wishlist),
              onAddCart: oldItemType.onAddProductCart,
            );
          } else if (supportWishlist is ProductBundle) {
            currentListItemControllerState = SupportVerticalGridVerticalProductBundleListItemControllerState(
              productBundle: supportWishlist,
              onRemoveWishlist: (productAppearanceData) => oldItemType.onRemoveWishlistWithWishlist(wishlist),
              onAddCart: oldItemType.onAddProductBundleCart,
            );
          }
          if (currentListItemControllerState != null) {
            return WishlistListItemControllerState(
              wishlist: wishlist,
              childListItemControllerState: currentListItemControllerState
            );
          } else {
            throw MessageError(title: "Support wishlist is not valid");
          }
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

class DefaultWishlistContainerInterceptingActionListItemControllerState extends WishlistContainerInterceptingActionListItemControllerState {
  void Function(Wishlist)? _removeWishlist;

  @override
  void Function(Wishlist)? get removeWishlist => _removeWishlist ?? (throw UnimplementedError());
}