import 'package:flutter/material.dart';

import '../../domain/entity/delivery/country_delivery_review.dart';
import '../constant.dart';
import '../controllerstate/listitemcontrollerstate/compound_list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/countrydeliveryreviewlistitemcontrollerstate/country_delivery_review_container_list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/countrydeliveryreviewlistitemcontrollerstate/country_delivery_review_list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/countrydeliveryreviewlistitemcontrollerstate/country_delivery_review_select_country_list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/failed_prompt_indicator_list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/fill_remaining_list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/padding_container_list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/spacing_list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/virtual_spacing_list_item_controller_state.dart';
import '../error/message_error.dart';
import '../itemtypelistinterceptor/itemtypelistinterceptorchecker/list_item_controller_state_item_type_list_interceptor_checker.dart';
import '../load_data_result.dart';
import '../multi_language_string.dart';
import '../typedef.dart';
import 'fill_remaining_item_type_list_sub_interceptor.dart';
import 'item_type_list_sub_interceptor.dart';

class CountryDeliveryReviewItemTypeListSubInterceptor extends ItemTypeListSubInterceptor<ListItemControllerState> {
  final DoubleReturned padding;
  final DoubleReturned itemSpacing;
  final ListItemControllerStateItemTypeInterceptorChecker listItemControllerStateItemTypeInterceptorChecker;

  CountryDeliveryReviewItemTypeListSubInterceptor({
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
    List<ListItemControllerState> newListItemControllerStateList = [];
    ListItemControllerState oldItemType = oldItemTypeWrapper.listItemControllerState;
    if (oldItemType is CountryDeliveryReviewContainerListItemControllerState) {
      listItemControllerStateItemTypeInterceptorChecker.interceptEachListItem(
        i, ListItemControllerStateWrapper(oldItemType.getCountryDeliveryReviewHeaderListItemControllerState()), oldItemTypeList, newListItemControllerStateList
      );
      listItemControllerStateItemTypeInterceptorChecker.interceptEachListItem(
        i, ListItemControllerStateWrapper(VirtualSpacingListItemControllerState(height: 16)), oldItemTypeList, newListItemControllerStateList
      );
      listItemControllerStateItemTypeInterceptorChecker.interceptEachListItem(
        i,
        ListItemControllerStateWrapper(
          PaddingContainerListItemControllerState(
            padding: EdgeInsets.symmetric(horizontal: padding()),
            paddingChildListItemControllerState: oldItemType.getCountryDeliveryReviewSelectCountryListItemControllerState(),
          )
        ),
        oldItemTypeList,
        newListItemControllerStateList
      );
      if (oldItemType.countryDeliveryReviewList.isEmpty) {
        listItemControllerStateItemTypeInterceptorChecker.interceptEachListItem(
          i, ListItemControllerStateWrapper(VirtualSpacingListItemControllerState(height: 16)), oldItemTypeList, newListItemControllerStateList
        );
        listItemControllerStateItemTypeInterceptorChecker.interceptEachListItem(
          i,
          ListItemControllerStateWrapper(
            FailedPromptIndicatorListItemControllerState(
              errorProvider: oldItemType.errorProvider,
              e: FailedLoadDataResult.throwException(() => throw MultiLanguageMessageError(
                title: MultiLanguageString({
                  Constant.textEnUsLanguageKey: "Country Review Is Empty",
                  Constant.textInIdLanguageKey: "Ulasan Negara Kosong",
                }),
                message: MultiLanguageString({
                  Constant.textEnUsLanguageKey: "Country Review in selected country is empty.",
                  Constant.textInIdLanguageKey: "Ulasan Negara di negara yang dipilih kosong.",
                }),
              ))!.e,
            )
          ),
          oldItemTypeList,
          newListItemControllerStateList
        );
        newItemTypeList.addAll(newListItemControllerStateList);
        return true;
      }
      listItemControllerStateItemTypeInterceptorChecker.interceptEachListItem(
        i, ListItemControllerStateWrapper(oldItemType.getCountryDeliveryReviewMediaShortContentListItemControllerState()), oldItemTypeList, newListItemControllerStateList
      );
      int j = 0;
      while (j < oldItemType.countryDeliveryReviewList.length) {
        CountryDeliveryReview countryDeliveryReview = oldItemType.countryDeliveryReviewList[j];
        ListItemControllerState countryDeliveryReviewListItemControllerState = CompoundListItemControllerState(
          listItemControllerState: [
            SpacingListItemControllerState(),
            CountryDeliveryReviewListItemControllerState(countryDeliveryReview: countryDeliveryReview)
          ]
        );
        listItemControllerStateItemTypeInterceptorChecker.interceptEachListItem(
          i, ListItemControllerStateWrapper(countryDeliveryReviewListItemControllerState), oldItemTypeList, newListItemControllerStateList
        );
        j++;
      }
      newItemTypeList.addAll(newListItemControllerStateList);
      return true;
    }
    return false;
  }
}