import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:masterbagasi/misc/ext/string_ext.dart';
import 'package:sizer/sizer.dart';

import '../controllerstate/listitemcontrollerstate/expandable_description_list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/virtual_spacing_list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/widget_substitution_list_item_controller_state.dart';
import 'item_type_list_sub_interceptor.dart';

class ExpandableDescriptionItemTypeListSubInterceptor extends ItemTypeListSubInterceptor<ListItemControllerState> {
  @override
  bool intercept(
    int i,
    ListItemControllerStateWrapper oldItemTypeWrapper,
    List<ListItemControllerState> oldItemTypeList,
    List<ListItemControllerState> newItemTypeList
  ) {
    ListItemControllerState oldItemType = oldItemTypeWrapper.listItemControllerState;
    if (oldItemType is ExpandableDescriptionListItemControllerState) {
      ExpandableDescriptionListValueWrapper expandableDescriptionListValueWrapper = oldItemType.expandableDescriptionListValueWrapper;
      bool hasShortDescription = !expandableDescriptionListValueWrapper.shortDescription.isEmptyString;
      bool hasDescription = !expandableDescriptionListValueWrapper.description.isEmptyString;
      bool hasAllDescription = hasShortDescription && hasDescription;
      newItemTypeList.add(
        WidgetSubstitutionListItemControllerState(
          widgetSubstitution: (BuildContext context, int index) {
            String? html;
            if (hasShortDescription && !hasDescription) {
              html = expandableDescriptionListValueWrapper.shortDescription!;
            } else if (!hasShortDescription && hasDescription) {
              html = expandableDescriptionListValueWrapper.description!;
            } else if (hasAllDescription) {
              html = expandableDescriptionListValueWrapper.expand
                ? expandableDescriptionListValueWrapper.description!
                : expandableDescriptionListValueWrapper.shortDescription!;
            }
            return HtmlWidget(html.toStringNonNull);
          },
        ),
      );
      if (hasAllDescription) {
        newItemTypeList.addAll(
          <ListItemControllerState>[
            VirtualSpacingListItemControllerState(
              height: 2.h
            ),
            WidgetSubstitutionListItemControllerState(
              widgetSubstitution: (BuildContext context, int index) => GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  expandableDescriptionListValueWrapper.expand = !expandableDescriptionListValueWrapper.expand;
                  if (expandableDescriptionListValueWrapper.onUpdateListItemControllerState != null) {
                    expandableDescriptionListValueWrapper.onUpdateListItemControllerState!();
                  }
                },
                child: Text(
                  !expandableDescriptionListValueWrapper.expand ? "More".tr : "Less".tr,
                  style: TextStyle(color: Theme.of(context).colorScheme.primary)
                ),
              )
            ),
          ]
        );
      }
      return true;
    }
    return false;
  }
}