import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constant.dart';
import '../controllerstate/listitemcontrollerstate/compound_list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/faqlistitemcontrollerstate/faq_container_list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/faqlistitemcontrollerstate/faq_detail_list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/faqlistitemcontrollerstate/faq_list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/padding_container_list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/productdiscussionlistitemcontrollerstate/vertical_product_discussion_list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/spacing_list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/title_and_description_list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/virtual_spacing_list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/widget_substitution_list_item_controller_state.dart';
import '../itemtypelistinterceptor/itemtypelistinterceptorchecker/list_item_controller_state_item_type_list_interceptor_checker.dart';
import '../typedef.dart';
import 'item_type_list_sub_interceptor.dart';

class FaqItemTypeListSubInterceptor extends ItemTypeListSubInterceptor<ListItemControllerState> {
  final DoubleReturned padding;
  final DoubleReturned itemSpacing;
  final ListItemControllerStateItemTypeInterceptorChecker listItemControllerStateItemTypeInterceptorChecker;

  FaqItemTypeListSubInterceptor({
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
    if (oldItemType is FaqContainerListItemControllerState) {
      List<FaqListItemControllerState> faqListItemControllerStateList = oldItemType.faqListItemValueList.map<FaqListItemControllerState>(
        (faqListItemValue) => FaqListItemControllerState(
          faq: faqListItemValue.faq,
          isExpanded: faqListItemValue.isExpanded,
          onTap: () {
            faqListItemValue.isExpanded = !faqListItemValue.isExpanded;
            oldItemType.onUpdateState();
          }
        )
      ).toList();
      List<ListItemControllerState> newListItemControllerState = [];
      List<InlineSpan> inlineSpanList = [
        const TextSpan(text: "FAQ ", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        const TextSpan(text: "(Frequently Asked Question)", style: TextStyle(color: Colors.grey)),
      ];
      ListItemControllerState faqHeaderListItemControllerState = WidgetSubstitutionListItemControllerState(
        widgetSubstitution: (context, index) => Container(
          padding: const EdgeInsets.all(16.0),
          color: Constant.colorDarkBlue,
          child: Row(
            children: [
              Text.rich(
                TextSpan(
                  children: inlineSpanList
                )
              )
            ],
          ),
        ),
      );
      listItemControllerStateItemTypeInterceptorChecker.interceptEachListItem(
        i, ListItemControllerStateWrapper(faqHeaderListItemControllerState), oldItemTypeList, newListItemControllerState
      );
      int j = 0;
      while (j < faqListItemControllerStateList.length) {
        ListItemControllerState listItemControllerState = CompoundListItemControllerState(
          listItemControllerState: [
            if (j > 0) SpacingListItemControllerState(height: 5),
            faqListItemControllerStateList[j],
            if (faqListItemControllerStateList[j].isExpanded)
              PaddingContainerListItemControllerState(
                padding: EdgeInsets.only(left: padding(), right: padding(), bottom: 10),
                paddingChildListItemControllerState: FaqDetailListItemControllerState(
                  faq: faqListItemControllerStateList[j].faq
                ),
              ),
            if (j == faqListItemControllerStateList.length - 1) VirtualSpacingListItemControllerState(height: padding())
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