import 'package:flutter/material.dart';

import '../../presentation/widget/profile_dropdown_menu_item.dart';
import '../../presentation/widget/profile_menu_item.dart';
import '../controllerstate/listitemcontrollerstate/divider_list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/padding_container_list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/profilemenulistitemcontrollerstate/profile_dropdown_menu_list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/profilemenulistitemcontrollerstate/profile_menu_group_list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/profilemenulistitemcontrollerstate/profile_menu_list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/widget_substitution_list_item_controller_state.dart';
import '../itemtypelistinterceptor/itemtypelistinterceptorchecker/list_item_controller_state_item_type_list_interceptor_checker.dart';
import '../typedef.dart';
import 'item_type_list_sub_interceptor.dart';

class ProfileItemTypeListSubInterceptor extends ItemTypeListSubInterceptor<ListItemControllerState> {
  final DoubleReturned padding;
  final DoubleReturned itemSpacing;
  final ListItemControllerStateItemTypeInterceptorChecker listItemControllerStateItemTypeInterceptorChecker;

  ProfileItemTypeListSubInterceptor({
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
    if (oldItemType is ProfileMenuListItemControllerState) {
      newItemTypeList.add(
        WidgetSubstitutionListItemControllerState(
          widgetSubstitution: (BuildContext context, int index) => ProfileMenuItem(
            onTap: oldItemType.onTap != null ? () => oldItemType.onTap!(context) : null,
            icon: oldItemType.icon,
            title: oldItemType.title,
            titleInterceptor: oldItemType.titleInterceptor,
            description: oldItemType.description,
            descriptionInterceptor: oldItemType.descriptionInterceptor,
            color: oldItemType.color
          )
        )
      );
      return true;
    } else if (oldItemType is ProfileDropdownMenuListItemControllerState) {
      newItemTypeList.add(
        WidgetSubstitutionListItemControllerState(
          widgetSubstitution: (BuildContext context, int index) => ProfileDropdownMenuItem(
            onTap: oldItemType.onTap != null ? () => oldItemType.onTap!(context) : () {
              oldItemType.isExpand = !oldItemType.isExpand;
              oldItemType.onUpdateState();
            },
            title: oldItemType.title,
            description: oldItemType.description,
            color: oldItemType.color,
            isExpand: oldItemType.isExpand
          )
        )
      );
      if (oldItemType.isExpand) {
        int j = 0;
        while (j < oldItemType.profileMenuListItemControllerStateList.length) {
          ProfileMenuListItemControllerState profileMenuListItemControllerState = oldItemType.profileMenuListItemControllerStateList[j];
          listItemControllerStateItemTypeInterceptorChecker.interceptEachListItem(
            i, ListItemControllerStateWrapper(profileMenuListItemControllerState), oldItemTypeList, newItemTypeList
          );
          j++;
        }
      }
      return true;
    } else if (oldItemType is ProfileMenuGroupListItemControllerState) {
      int j = 0;
      while (j < oldItemType.profileMenuListItemControllerStateList.length) {
        if (j > 0) {
          newItemTypeList.add(
            PaddingContainerListItemControllerState(
              padding: EdgeInsets.symmetric(horizontal: padding()),
              paddingChildListItemControllerState: DividerListItemControllerState(),
            )
          );
        }
        ProfileMenuListItemControllerState profileMenuListItemControllerState = oldItemType.profileMenuListItemControllerStateList[j];
        intercept(i, ListItemControllerStateWrapper(profileMenuListItemControllerState), oldItemTypeList, newItemTypeList);
        j++;
      }
      return true;
    }
    return false;
  }
}