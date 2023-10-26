import 'package:flutter/material.dart';

import '../controllerstate/listitemcontrollerstate/colorful_chip_tab_bar_list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/compound_list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/notificationlistitemcontrollerstate/notification_container_list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/notificationlistitemcontrollerstate/notification_list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/padding_container_list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/virtual_spacing_list_item_controller_state.dart';
import '../itemtypelistinterceptor/itemtypelistinterceptorchecker/list_item_controller_state_item_type_list_interceptor_checker.dart';
import '../typedef.dart';
import 'item_type_list_sub_interceptor.dart';

class NotificationItemTypeListSubInterceptor extends ItemTypeListSubInterceptor<ListItemControllerState> {
  final DoubleReturned padding;
  final DoubleReturned itemSpacing;
  final ListItemControllerStateItemTypeInterceptorChecker listItemControllerStateItemTypeInterceptorChecker;

  NotificationItemTypeListSubInterceptor({
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
    if (oldItemType is NotificationContainerListItemControllerState) {
      List<NotificationListItemControllerState> notificationListItemControllerStateList = oldItemType.notificationList.map<NotificationListItemControllerState>(
        (shortNotification) => NotificationListItemControllerState(shortNotification: shortNotification)
      ).toList();
      List<ListItemControllerState> newListItemControllerState = [];
      newListItemControllerState.add(
        ColorfulChipTabBarListItemControllerState(
          colorfulChipTabBarController: oldItemType.notificationTabColorfulChipTabBarController,
          colorfulChipTabBarDataList: oldItemType.notificationColorfulChipTabBarDataList,
          isWrap: false
        ),
      );
      newListItemControllerState.add(
        VirtualSpacingListItemControllerState(height: padding())
      );
      int j = 0;
      while (j < notificationListItemControllerStateList.length) {
        ListItemControllerState listItemControllerState = CompoundListItemControllerState(
          listItemControllerState: [
            if (j > 0) VirtualSpacingListItemControllerState(height: itemSpacing()),
            PaddingContainerListItemControllerState(
              padding: EdgeInsets.symmetric(horizontal: padding()),
              paddingChildListItemControllerState: notificationListItemControllerStateList[j],
            ),
            if (j == notificationListItemControllerStateList.length - 1) VirtualSpacingListItemControllerState(height: padding())
          ]
        );
        listItemControllerStateItemTypeInterceptorChecker.interceptEachListItem(
          i, ListItemControllerStateWrapper(listItemControllerState), oldItemTypeList, newListItemControllerState
        );
        j++;
      }
      newItemTypeList.addAll(newListItemControllerState);
      return true;
    }
    return false;
  }
}