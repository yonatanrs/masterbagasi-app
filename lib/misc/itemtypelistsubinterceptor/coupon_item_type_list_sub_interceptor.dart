import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../domain/entity/coupon/coupon.dart';
import '../controllerstate/listitemcontrollerstate/compound_list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/couponlistitemcontrollerstate/coupon_container_list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/couponlistitemcontrollerstate/vertical_coupon_list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/padding_container_list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/virtual_spacing_list_item_controller_state.dart';
import '../itemtypelistinterceptor/itemtypelistinterceptorchecker/list_item_controller_state_item_type_list_interceptor_checker.dart';
import '../typedef.dart';
import 'item_type_list_sub_interceptor.dart';

class CouponItemTypeListSubInterceptor extends ItemTypeListSubInterceptor<ListItemControllerState> {
  final DoubleReturned padding;
  final DoubleReturned itemSpacing;
  final ListItemControllerStateItemTypeInterceptorChecker listItemControllerStateItemTypeInterceptorChecker;

  CouponItemTypeListSubInterceptor({
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
    if (oldItemType is CouponContainerListItemControllerState) {
      DefaultCouponContainerStorageListItemControllerState defaultCouponContainerStorageListItemControllerState = oldItemType.couponContainerStorageListItemControllerState as DefaultCouponContainerStorageListItemControllerState;
      if (!defaultCouponContainerStorageListItemControllerState._hasInitSelectedCoupon) {
        defaultCouponContainerStorageListItemControllerState._hasInitSelectedCoupon = true;
        String? selectedCouponId = oldItemType.onGetLastSelectedCouponId!();
        Coupon? selectedIteratedCoupon;
        for (var iteratedCoupon in oldItemType.coupon) {
          if (iteratedCoupon.id == selectedCouponId) {
            selectedIteratedCoupon = iteratedCoupon;
            break;
          }
        }
        if (selectedIteratedCoupon != null) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            if (oldItemType.onSelectCoupon != null) {
              oldItemType.onSelectCoupon!(selectedIteratedCoupon!);
            }
          });
        }
      }
      List<ListItemControllerState> resultListItemControllerStateList = oldItemType.coupon.mapIndexed<ListItemControllerState>(
        (index, coupon) {
          Coupon? selectedCoupon = oldItemType.onGetSelectedCoupon!();
          return CompoundListItemControllerState(
            listItemControllerState: [
              VirtualSpacingListItemControllerState(height: padding()),
              PaddingContainerListItemControllerState(
                padding: EdgeInsets.symmetric(horizontal: padding()),
                paddingChildListItemControllerState: VerticalCouponListItemControllerState(
                  coupon: coupon,
                  onSelectCoupon: oldItemType.onSelectCoupon!,
                  isSelected: selectedCoupon?.id == coupon.id
                ),
              ),
              if (index == oldItemType.coupon.length - 1) VirtualSpacingListItemControllerState(height: padding()),
            ]
          );
        }
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

class DefaultCouponContainerStorageListItemControllerState extends CouponContainerStorageListItemControllerState {
  bool _hasInitSelectedCoupon = false;
}