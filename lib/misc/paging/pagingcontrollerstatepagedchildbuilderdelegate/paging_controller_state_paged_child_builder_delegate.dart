import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../presentation/widget/modified_loading_indicator.dart';
import '../../constant.dart';
import '../../controllerstate/paging_controller_state.dart';
import '../../typedef.dart';
import '../modified_paging_controller.dart';

class PagingControllerStatePagedChildBuilderDelegate<PageKeyType, ItemType> extends PagedChildBuilderDelegate<ItemType> {
  final PagingControllerState<PageKeyType, ItemType> pagingControllerState;
  final WidgetBuilderWithError? firstPageErrorIndicatorBuilderWithErrorParameter;
  final WidgetBuilderWithError? newPageErrorIndicatorBuilderWithErrorParameter;

  PagingControllerStatePagedChildBuilderDelegate({
    required this.pagingControllerState,
    required ItemWidgetBuilder<ItemType> itemBuilder,
    this.firstPageErrorIndicatorBuilderWithErrorParameter,
    this.newPageErrorIndicatorBuilderWithErrorParameter,
    WidgetBuilder? firstPageProgressIndicatorBuilder,
    WidgetBuilder? newPageProgressIndicatorBuilder,
    WidgetBuilder? noItemsFoundIndicatorBuilder,
    WidgetBuilder? noMoreItemsIndicatorBuilder,
    bool animateTransitions = false,
    final Duration transitionDuration = const Duration(milliseconds: 250),
  }) : super(
    itemBuilder: itemBuilder,
    firstPageErrorIndicatorBuilder: firstPageErrorIndicatorBuilderWithErrorParameter != null ? (
      (context) {
        PagingController pagingController = pagingControllerState.pagingController;
        if (pagingController is ModifiedPagingController) {
          late final dynamic e;
          if (pagingController.errorFirstPageOuterProcess != null) {
            e = pagingController.errorFirstPageOuterProcess;
          } else {
            e = pagingController.error;
          }
          return firstPageErrorIndicatorBuilderWithErrorParameter(context, e);
        } else {
          return firstPageErrorIndicatorBuilderWithErrorParameter(context, pagingControllerState.pagingController.error);
        }
      }
    ) : null,
    newPageErrorIndicatorBuilder: newPageErrorIndicatorBuilderWithErrorParameter != null ? (
      (context) {
        PagingController pagingController = pagingControllerState.pagingController;
        if (pagingController is ModifiedPagingController) {
          late final dynamic e;
          if (pagingController.errorFirstPageOuterProcess != null) {
            e = pagingController.errorFirstPageOuterProcess;
          } else {
            e = pagingController.error;
          }
          return newPageErrorIndicatorBuilderWithErrorParameter(context, e);
        } else {
          return newPageErrorIndicatorBuilderWithErrorParameter(context, pagingControllerState.pagingController.error);
        }
      }
    ) : null,
    firstPageProgressIndicatorBuilder: firstPageProgressIndicatorBuilder ?? (
      (context) => Padding(
        padding: EdgeInsets.all(Constant.spacingListItem),
        child: const Center(child: ModifiedLoadingIndicator())
      )
    ),
    newPageProgressIndicatorBuilder: newPageProgressIndicatorBuilder ?? (
      (context) => Padding(
        padding: EdgeInsets.all(Constant.paddingListItem),
        child: const Center(child: ModifiedLoadingIndicator())
      )
    ),
    noItemsFoundIndicatorBuilder: noItemsFoundIndicatorBuilder,
    noMoreItemsIndicatorBuilder: noMoreItemsIndicatorBuilder,
    animateTransitions: animateTransitions,
    transitionDuration: transitionDuration
  );
}