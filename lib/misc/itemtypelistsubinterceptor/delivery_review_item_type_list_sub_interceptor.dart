import 'package:flutter/material.dart';
import 'package:masterbagasi/domain/entity/user/user.dart';
import 'package:masterbagasi/misc/load_data_result.dart';

import '../../domain/entity/delivery/delivery_review.dart';
import '../controllerstate/listitemcontrollerstate/compound_list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/deliveryreviewlistitemcontrollerstate/deliveryreviewdetaillistitemcontrollerstate/check_your_contribution_delivery_review_detail_list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/deliveryreviewlistitemcontrollerstate/deliveryreviewdetaillistitemcontrollerstate/delivery_review_detail_list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/deliveryreviewlistitemcontrollerstate/deliveryreviewdetaillistitemcontrollerstate/history_delivery_review_detail_container_list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/deliveryreviewlistitemcontrollerstate/deliveryreviewdetaillistitemcontrollerstate/vertical_delivery_review_detail_list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/deliveryreviewlistitemcontrollerstate/deliveryreviewdetaillistitemcontrollerstate/waiting_to_be_reviewed_delivery_review_detail_container_list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/padding_container_list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/virtual_spacing_list_item_controller_state.dart';
import '../itemtypelistinterceptor/itemtypelistinterceptorchecker/list_item_controller_state_item_type_list_interceptor_checker.dart';
import '../typedef.dart';
import 'item_type_list_sub_interceptor.dart';

class DeliveryReviewItemTypeListSubInterceptor extends ItemTypeListSubInterceptor<ListItemControllerState> {
  final DoubleReturned padding;
  final DoubleReturned itemSpacing;
  final ListItemControllerStateItemTypeInterceptorChecker listItemControllerStateItemTypeInterceptorChecker;

  DeliveryReviewItemTypeListSubInterceptor({
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
    if (oldItemType is WaitingToBeReviewedDeliveryReviewDetailContainerListItemControllerState) {
      return _onInterceptWaitingToBeReviewedDeliveryReviewDetail(i, oldItemTypeWrapper, oldItemTypeList, newItemTypeList);
    } else if (oldItemType is HistoryDeliveryReviewDetailContainerListItemControllerState) {
      return _onInterceptHistoryDeliveryReviewDetail(i, oldItemTypeWrapper, oldItemTypeList, newItemTypeList);
    }
    return false;
  }

  bool _onInterceptWaitingToBeReviewedDeliveryReviewDetail(
    int i,
    ListItemControllerStateWrapper oldItemTypeWrapper,
    List<ListItemControllerState> oldItemTypeList,
    List<ListItemControllerState> newItemTypeList
  ) {
    List<ListItemControllerState> newListItemControllerStateList = [];
    int j = 0;
    WaitingToBeReviewedDeliveryReviewDetailContainerListItemControllerState oldItemType = oldItemTypeWrapper.listItemControllerState as WaitingToBeReviewedDeliveryReviewDetailContainerListItemControllerState;
    if (oldItemType.waitingToBeReviewedDeliveryReviewDetailContainerInterceptingActionListItemControllerState is DefaultWaitingToBeReviewedDeliveryReviewDetailContainerInterceptingActionListItemControllerState) {
      var waitingToBeReviewedDeliveryReviewDetailContainer = oldItemType.waitingToBeReviewedDeliveryReviewDetailContainerInterceptingActionListItemControllerState as DefaultWaitingToBeReviewedDeliveryReviewDetailContainerInterceptingActionListItemControllerState;
      waitingToBeReviewedDeliveryReviewDetailContainer._onImplementUserLoadDataResult = (userLoadDataResult) {
        return CompoundListItemControllerState(
          listItemControllerState: [
            VirtualSpacingListItemControllerState(height: padding()),
            PaddingContainerListItemControllerState(
              padding: EdgeInsets.symmetric(horizontal: padding()),
              paddingChildListItemControllerState: CheckYourContributionDeliveryReviewDetailListItemControllerState(
                userLoadDataResult: userLoadDataResult,
                errorProvider: oldItemType.errorProvider,
                onTap: oldItemType.onTapCheckYourContribution
              )
            )
          ]
        );
      };
      if (oldItemType.waitingToBeReviewedDeliveryReviewDetailContainerStorageListItemControllerState is DefaultWaitingToBeReviewedDeliveryReviewDetailContainerStorageListItemControllerState) {
        var waitingToBeReviewedDeliveryReviewDetailContainerStorage = oldItemType.waitingToBeReviewedDeliveryReviewDetailContainerStorageListItemControllerState as DefaultWaitingToBeReviewedDeliveryReviewDetailContainerStorageListItemControllerState;
        waitingToBeReviewedDeliveryReviewDetailContainerStorage._checkYourContributionDeliveryReviewDetailListItemControllerState ??= oldItemType.getCheckYourContributionDeliveryReviewDetailListItemControllerState();
        listItemControllerStateItemTypeInterceptorChecker.interceptEachListItem(
          i, ListItemControllerStateWrapper(waitingToBeReviewedDeliveryReviewDetailContainerStorage._checkYourContributionDeliveryReviewDetailListItemControllerState!), oldItemTypeList, newListItemControllerStateList
        );
      }
    }
    while (j < oldItemType.deliveryReviewList.length) {
      DeliveryReview deliveryReview = oldItemType.deliveryReviewList[j];
      ListItemControllerState verticalDeliveryReviewDetailListItemControllerState = CompoundListItemControllerState(
        listItemControllerState: [
          VirtualSpacingListItemControllerState(height: itemSpacing()),
          PaddingContainerListItemControllerState(
            padding: EdgeInsets.symmetric(horizontal: padding()),
            paddingChildListItemControllerState: VerticalDeliveryReviewDetailListItemControllerState(
              deliveryReview: deliveryReview,
              deliveryReviewDetailType: DeliveryReviewDetailType.waitingToBeReviewed,
              onDeliveryReviewRatingTap: oldItemType.onWaitingToBeReviewedDeliveryReviewTap != null ? (selectedRating) => oldItemType.onWaitingToBeReviewedDeliveryReviewTap!(
                deliveryReview, selectedRating
              ) : null
            )
          ),
          if (j == oldItemType.deliveryReviewList.length - 1) VirtualSpacingListItemControllerState(height: itemSpacing()),
        ]
      );
      listItemControllerStateItemTypeInterceptorChecker.interceptEachListItem(
        i, ListItemControllerStateWrapper(verticalDeliveryReviewDetailListItemControllerState), oldItemTypeList, newListItemControllerStateList
      );
      j++;
    }
    newItemTypeList.addAll(newListItemControllerStateList);
    return true;
  }

  bool _onInterceptHistoryDeliveryReviewDetail(
    int i,
    ListItemControllerStateWrapper oldItemTypeWrapper,
    List<ListItemControllerState> oldItemTypeList,
    List<ListItemControllerState> newItemTypeList
  ) {
    HistoryDeliveryReviewDetailContainerListItemControllerState oldItemType = oldItemTypeWrapper.listItemControllerState as HistoryDeliveryReviewDetailContainerListItemControllerState;
    List<ListItemControllerState> newListItemControllerStateList = [];
    int j = 0;
    while (j < oldItemType.deliveryReviewList.length) {
      DeliveryReview deliveryReview = oldItemType.deliveryReviewList[j];
      ListItemControllerState verticalDeliveryReviewDetailListItemControllerState = CompoundListItemControllerState(
        listItemControllerState: [
          if (j == 0) VirtualSpacingListItemControllerState(height: padding()),
          if (j > 0) VirtualSpacingListItemControllerState(height: itemSpacing()),
          PaddingContainerListItemControllerState(
            padding: EdgeInsets.symmetric(horizontal: padding()),
            paddingChildListItemControllerState: VerticalDeliveryReviewDetailListItemControllerState(
              deliveryReview: deliveryReview,
              deliveryReviewDetailType: DeliveryReviewDetailType.history
            )
          ),
          if (j == oldItemType.deliveryReviewList.length - 1) VirtualSpacingListItemControllerState(height: itemSpacing()),
        ]
      );
      listItemControllerStateItemTypeInterceptorChecker.interceptEachListItem(
        i, ListItemControllerStateWrapper(verticalDeliveryReviewDetailListItemControllerState), oldItemTypeList, newListItemControllerStateList
      );
      j++;
    }
    newItemTypeList.addAll(newListItemControllerStateList);
    return true;
  }
}

class DefaultWaitingToBeReviewedDeliveryReviewDetailContainerInterceptingActionListItemControllerState extends WaitingToBeReviewedDeliveryReviewDetailContainerInterceptingActionListItemControllerState {
  ListItemControllerState Function(LoadDataResult<User>)? _onImplementUserLoadDataResult;

  @override
  ListItemControllerState Function(LoadDataResult<User>)? get onImplementUserLoadDataResult => _onImplementUserLoadDataResult ?? (throw UnimplementedError());
}

class DefaultWaitingToBeReviewedDeliveryReviewDetailContainerStorageListItemControllerState extends WaitingToBeReviewedDeliveryReviewDetailContainerStorageListItemControllerState {
  ListItemControllerState? _checkYourContributionDeliveryReviewDetailListItemControllerState;
}