import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

// ignore: implementation_imports
import 'package:infinite_scroll_pagination/src/ui/default_indicators/first_page_error_indicator.dart';
// ignore: implementation_imports
import 'package:infinite_scroll_pagination/src/ui/default_indicators/first_page_progress_indicator.dart';
// ignore: implementation_imports
import 'package:infinite_scroll_pagination/src/ui/default_indicators/new_page_error_indicator.dart';
// ignore: implementation_imports
import 'package:infinite_scroll_pagination/src/ui/default_indicators/new_page_progress_indicator.dart';
// ignore: implementation_imports
import 'package:infinite_scroll_pagination/src/ui/default_indicators/no_items_found_indicator.dart';
// ignore: implementation_imports
import 'package:infinite_scroll_pagination/src/utils/listenable_listener.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../../misc/additionalloadingindicatorchecker/additional_paging_result_parameter_checker.dart';
import '../../../misc/itemtypelistinterceptor/item_type_list_interceptor.dart';
import '../../../misc/itemtypelistinterceptor/item_type_list_interceptor_parameter.dart';
import '../../../misc/itemtypelistinterceptor/item_type_list_interceptor_result.dart';
import '../../../misc/paging/modified_paging_controller.dart';
import '../../../misc/paging/modified_paging_state.dart';
import '../../../misc/paging/pagingresult/paging_result_with_parameter.dart';

typedef ModifiedCompletedListingBuilder = Widget Function(
  BuildContext context,
  bool showOriginalLoaderIndicator,
  IndexedWidgetBuilder itemWidgetBuilder,
  IndexedWidgetBuilder additionalItemWidgetBuilder,
  int itemCount,
  int additionalItemCount,
  WidgetBuilder? noMoreItemsIndicatorBuilder,
);

typedef ModifiedErrorListingBuilder = Widget Function(
  BuildContext context,
  bool showOriginalLoaderIndicator,
  IndexedWidgetBuilder itemWidgetBuilder,
  IndexedWidgetBuilder additionalItemWidgetBuilder,
  int itemCount,
  int additionalItemCount,
  WidgetBuilder newPageErrorIndicatorBuilder,
);

typedef ModifiedLoadingListingBuilder = Widget Function(
  BuildContext context,
  bool showOriginalLoaderIndicator,
  IndexedWidgetBuilder itemWidgetBuilder,
  IndexedWidgetBuilder additionalItemWidgetBuilder,
  int itemCount,
  int additionalItemCount,
  WidgetBuilder newPageProgressIndicatorBuilder,
);

typedef ModifiedFirstLoadingListingBuilder = Widget Function(
  BuildContext context,
  bool showOriginalLoaderIndicator,
  IndexedWidgetBuilder itemWidgetBuilder,
  IndexedWidgetBuilder additionalItemWidgetBuilder,
  int itemCount,
  int additionalItemCount,
  WidgetBuilder newPageProgressIndicatorBuilder,
);

/// Assists the creation of infinitely scrolled paged sliver widgets.
///
/// Combines a [PagingController] with a
/// [PagedChildBuilderDelegate] and calls the supplied
/// [loadingListingBuilder], [errorListingBuilder] or
/// [completedListingBuilder] for filling in the gaps.
///
/// For ordinary cases, this widget shouldn't be used directly. Instead, take a
/// look at [PagedSliverList], [PagedSliverGrid],
/// [PagedGridView] and [PagedListView].
class ModifiedCustomPagedSliverBuilder<PageKeyType, ItemType> extends StatefulWidget {
  const ModifiedCustomPagedSliverBuilder({
    required this.pagingController,
    required this.builderDelegate,
    required this.modifiedFirstLoadingListingBuilder,
    required this.modifiedLoadingListingBuilder,
    required this.modifiedErrorListingBuilder,
    required this.modifiedCompletedListingBuilder,
    this.shrinkWrapFirstPageIndicators = false,
    required this.itemTypeListInterceptorList,
    Key? key,
  }) : super(key: key);

  /// The controller for paged listings.
  ///
  /// Informs the current state of the pagination and requests new items from
  /// its listeners.
  final PagingController<PageKeyType, ItemType> pagingController;

  /// The delegate for building the UI pieces of scrolling paged listings.
  final PagedChildBuilderDelegate<ItemType> builderDelegate;

  /// The builder for an first in-progress listing.
  final ModifiedFirstLoadingListingBuilder modifiedFirstLoadingListingBuilder;

  /// The builder for an in-progress listing.
  final ModifiedLoadingListingBuilder modifiedLoadingListingBuilder;

  /// The builder for an in-progress listing with a failed request.
  final ModifiedErrorListingBuilder modifiedErrorListingBuilder;

  /// The builder for a completed listing.
  final ModifiedCompletedListingBuilder modifiedCompletedListingBuilder;

  /// Whether the extent of the first page indicators should be determined by
  /// the contents being viewed.
  ///
  /// If the paged sliver builder does not shrink wrap, then the first page
  /// indicators will expand to the maximum allowed size. If the paged sliver
  /// builder has unbounded constraints, then [shrinkWrapFirstPageIndicators]
  /// must be true.
  ///
  /// Defaults to false.
  final bool shrinkWrapFirstPageIndicators;

  /// Item type interceptor list
  final List<ItemTypeListInterceptor<ItemType>> itemTypeListInterceptorList;

  @override
  State<ModifiedCustomPagedSliverBuilder<PageKeyType, ItemType>> createState() => _ModifiedCustomPagedSliverBuilderState<PageKeyType, ItemType>();
}

class _ModifiedCustomPagedSliverBuilderState<PageKeyType, ItemType> extends State<ModifiedCustomPagedSliverBuilder<PageKeyType, ItemType>> {
  PagingController<PageKeyType, ItemType> get _pagingController => widget.pagingController;

  PagedChildBuilderDelegate<ItemType> get _builderDelegate => widget.builderDelegate;

  bool get _shrinkWrapFirstPageIndicators => widget.shrinkWrapFirstPageIndicators;

  WidgetBuilder get _firstPageErrorIndicatorBuilder => _builderDelegate.firstPageErrorIndicatorBuilder ?? (_) => FirstPageErrorIndicator(
    onTryAgain: _pagingController.retryLastFailedRequest,
  );

  WidgetBuilder get _newPageErrorIndicatorBuilder => _builderDelegate.newPageErrorIndicatorBuilder ?? (_) => NewPageErrorIndicator(
    onTap: _pagingController.retryLastFailedRequest,
  );

  WidgetBuilder get _firstPageProgressIndicatorBuilder => _builderDelegate.firstPageProgressIndicatorBuilder ?? (_) => FirstPageProgressIndicator();

  WidgetBuilder get _newPageProgressIndicatorBuilder => _builderDelegate.newPageProgressIndicatorBuilder ?? (_) => const NewPageProgressIndicator();

  WidgetBuilder get _noItemsFoundIndicatorBuilder => _builderDelegate.noItemsFoundIndicatorBuilder ?? (_) => NoItemsFoundIndicator();

  WidgetBuilder? get _noMoreItemsIndicatorBuilder => _builderDelegate.noMoreItemsIndicatorBuilder;

  int get _invisibleItemsThreshold => _pagingController.invisibleItemsThreshold ?? 3;

  //int get _itemCount => _pagingController.itemCount;

  bool get _hasNextPage => _pagingController.hasNextPage;

  PageKeyType? get _nextKey => _pagingController.nextPageKey;

  /// Avoids duplicate requests on rebuilds.
  bool _hasRequestedNextPage = false;

  ItemTypeListInterceptorResult<ItemType>? _firstLoadingIndicatorItemTypeListInterceptorResult;
  bool _firstShowOriginalLoaderIndicator = true;

  @override
  Widget build(BuildContext context) {
    return ListenableListener(
      listenable: _pagingController,
      listener: () {
        final status = _pagingController.value.status;

        if (status == PagingStatus.loadingFirstPage) {
          _firstShowOriginalLoaderIndicator = true;
          if (_pagingController is ModifiedPagingController<PageKeyType, ItemType>) {
            List<ItemType> additionalItemList = [];
            ModifiedPagingController<PageKeyType, ItemType> modifiedPagingController = _pagingController as ModifiedPagingController<PageKeyType, ItemType>;
            PagingResultParameter<ItemType>? pagingResultParameter = modifiedPagingController.getLoaderIndicatorInLoadedPageKey(_pagingController.firstPageKey);
            if (pagingResultParameter != null) {
              List<ItemType>? receivedAdditionalItemList = pagingResultParameter.additionalItemList;
              if (receivedAdditionalItemList != null) {
                additionalItemList = receivedAdditionalItemList;
              }
              _firstLoadingIndicatorItemTypeListInterceptorResult = _interceptListItem(_pagingController.itemList ?? [], additionalItemList);
              _firstShowOriginalLoaderIndicator = pagingResultParameter.showOriginalLoaderIndicator;
            }
          }
          _hasRequestedNextPage = false;
          _pagingController.notifyPageRequestListeners(_pagingController.firstPageKey);
        }

        if (status == PagingStatus.ongoing) {
          _hasRequestedNextPage = false;
        }
      },
      child: ValueListenableBuilder<PagingState<PageKeyType, ItemType>>(
        valueListenable: _pagingController,
        builder: (context, pagingState, _) {
          Widget child;
          List<ItemType> additionalItemList = [];
          bool hasTriggerLoader = true;
          bool showOriginalLoaderIndicator = true;
          if (pagingState is ModifiedPagingState<PageKeyType, ItemType>) {
            PagingResultParameter<ItemType>? pagingResultParameter = pagingState.pagingResultParameter;
            if (pagingResultParameter != null) {
              List<ItemType>? receivedAdditionalItemList = pagingResultParameter.additionalItemList;
              if (receivedAdditionalItemList != null) {
                additionalItemList = receivedAdditionalItemList;
              }
              showOriginalLoaderIndicator = pagingResultParameter.showOriginalLoaderIndicator;
            }
            hasTriggerLoader = pagingState.hasTriggerLoader;
          }
          ItemTypeListInterceptorResult<ItemType> itemTypeListInterceptorResult = _interceptListItem(_pagingController.itemList ?? [], additionalItemList);
          List<ItemType> firstLoadingIndicatorAdditionalItemTypeList = _firstLoadingIndicatorItemTypeListInterceptorResult != null ? _firstLoadingIndicatorItemTypeListInterceptorResult!.interceptedAdditionalItemTypeList : [];
          switch (pagingState.status) {
            case PagingStatus.ongoing:
              child = widget.modifiedLoadingListingBuilder(
                context,
                showOriginalLoaderIndicator,
                // We must create this closure to close over the [itemList]
                // value. That way, we are safe if [itemList] value changes
                // while Flutter rebuilds the widget (due to animations, for
                // example.)
                (context, index) => _buildListItemWidget(
                  context,
                  index,
                  itemTypeListInterceptorResult.interceptedItemTypeList,
                  itemTypeListInterceptorResult.interceptedAdditionalItemTypeList,
                  hasTriggerLoader
                ),
                // We must create this closure to close over the [itemList]
                // value. That way, we are safe if [itemList] value changes
                // while Flutter rebuilds the widget (due to animations, for
                // example.)
                (context, index) => _buildListItemWidget(
                  context,
                  index,
                  itemTypeListInterceptorResult.interceptedItemTypeList,
                  itemTypeListInterceptorResult.interceptedAdditionalItemTypeList,
                  hasTriggerLoader
                ),
                itemTypeListInterceptorResult.interceptedItemTypeList.length,
                itemTypeListInterceptorResult.interceptedAdditionalItemTypeList.length,
                showOriginalLoaderIndicator ? _newPageProgressIndicatorBuilder : (context) => const SizedBox(),
              );
              break;
            case PagingStatus.completed:
              child = widget.modifiedCompletedListingBuilder(
                context,
                showOriginalLoaderIndicator,
                (context, index) => _buildListItemWidget(
                  context,
                  index,
                  itemTypeListInterceptorResult.interceptedItemTypeList,
                  itemTypeListInterceptorResult.interceptedAdditionalItemTypeList,
                  hasTriggerLoader
                ),
                (context, index) => _buildListItemWidget(
                  context,
                  index,
                  itemTypeListInterceptorResult.interceptedItemTypeList,
                  itemTypeListInterceptorResult.interceptedAdditionalItemTypeList,
                  hasTriggerLoader
                ),
                itemTypeListInterceptorResult.interceptedItemTypeList.length,
                itemTypeListInterceptorResult.interceptedAdditionalItemTypeList.length,
                _noMoreItemsIndicatorBuilder,
              );
              break;
            case PagingStatus.loadingFirstPage:
              child = _firstShowOriginalLoaderIndicator ? _FirstPageStatusIndicatorBuilder(
                builder: _firstPageProgressIndicatorBuilder,
                shrinkWrap: _shrinkWrapFirstPageIndicators,
              ) : widget.modifiedFirstLoadingListingBuilder(
                context,
                showOriginalLoaderIndicator,
                (context, index) => _buildListItemWidget(
                  context,
                  index,
                  firstLoadingIndicatorAdditionalItemTypeList,
                  [],
                  hasTriggerLoader,
                  preventLoadNextPageWhileInFirstLoading: true
                ),
                (context, index) => _buildListItemWidget(
                  context,
                  index,
                  firstLoadingIndicatorAdditionalItemTypeList,
                  [],
                  hasTriggerLoader,
                  preventLoadNextPageWhileInFirstLoading: true
                ),
                firstLoadingIndicatorAdditionalItemTypeList.length,
                0,
                    (context) => const SizedBox(),
              );
              break;
            case PagingStatus.subsequentPageError:
              child = widget.modifiedErrorListingBuilder(
                context,
                showOriginalLoaderIndicator,
                (context, index) => _buildListItemWidget(
                  context,
                  index,
                  itemTypeListInterceptorResult.interceptedItemTypeList,
                  itemTypeListInterceptorResult.interceptedAdditionalItemTypeList,
                  hasTriggerLoader
                ),
                (context, index) => _buildListItemWidget(
                  context,
                  index,
                  itemTypeListInterceptorResult.interceptedItemTypeList,
                  itemTypeListInterceptorResult.interceptedAdditionalItemTypeList,
                  hasTriggerLoader
                ),
                itemTypeListInterceptorResult.interceptedItemTypeList.length,
                itemTypeListInterceptorResult.interceptedAdditionalItemTypeList.length,
                  (context) => _newPageErrorIndicatorBuilder(context),
              );
              break;
            case PagingStatus.noItemsFound:
              child = _FirstPageStatusIndicatorBuilder(
                builder: _noItemsFoundIndicatorBuilder,
                shrinkWrap: _shrinkWrapFirstPageIndicators,
              );
              break;
            default:
              child = _FirstPageStatusIndicatorBuilder(
                builder: _firstPageErrorIndicatorBuilder,
                shrinkWrap: _shrinkWrapFirstPageIndicators,
              );
          }
          if (_builderDelegate.animateTransitions) {
            return SliverAnimatedSwitcher(
              duration: _builderDelegate.transitionDuration,
              child: Container(
                // The `ObjectKey` makes it possible to differentiate
                // transitions between same Widget types, e.g., ongoing to
                // completed.
                key: ObjectKey(pagingState),
                child: child,
              ),
            );
          } else {
            return child;
          }
        },
      ),
    );
  }

  ItemTypeListInterceptorResult<ItemType> _interceptListItem(List<ItemType> itemTypeList, List<ItemType> additionalItemTypeList) {
    List<ItemTypeListInterceptor<ItemType>> itemTypeListInterceptorList = widget.itemTypeListInterceptorList;
    int length = itemTypeListInterceptorList.length;
    if (length == 0) {
      return ItemTypeListInterceptorResult(
        allInterceptedItemTypeList: itemTypeList + additionalItemTypeList,
        interceptedItemTypeList: itemTypeList,
        interceptedAdditionalItemTypeList: additionalItemTypeList
      );
    }
    int i = 0;
    ItemTypeListInterceptorResult<ItemType> itemTypeListInterceptorResult = ItemTypeListInterceptorResult<ItemType>(
      allInterceptedItemTypeList: [],
      interceptedItemTypeList: [],
      interceptedAdditionalItemTypeList: []
    );
    while (i < length) {
      itemTypeListInterceptorResult = itemTypeListInterceptorList[i].intercept(
        itemTypeList,
        ItemTypeListInterceptorParameter<ItemType>(
          additionalItemTypeList: additionalItemTypeList,
        )
      );
      i += 1;
    }
    return itemTypeListInterceptorResult;
  }

  /// Connects the [_pagingController] with the [_builderDelegate] in order to
  /// create a list item widget and request more items if needed.
  Widget _buildListItemWidget(
    BuildContext context,
    int index,
    List<ItemType> itemList,
    List<ItemType> additionalItemList,
    bool hasTriggerLoader,
    {bool preventLoadNextPageWhileInFirstLoading = false}
  ) {
    if (!_hasRequestedNextPage) {
      final newPageRequestTriggerIndex = max(0, itemList.length - _invisibleItemsThreshold);
      final isBuildingTriggerIndexItem = index == newPageRequestTriggerIndex;
      if (_hasNextPage && isBuildingTriggerIndexItem && !preventLoadNextPageWhileInFirstLoading) {
        // Schedules the request for the end of this frame.
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _pagingController.notifyPageRequestListeners(_nextKey!);
        });
        _hasRequestedNextPage = true;
      }
    }

    final accumulationItemList = itemList + additionalItemList;
    final item = accumulationItemList[index];
    return _builderDelegate.itemBuilder(context, item, index);
  }
}

extension on PagingController {
  /// Tells whether there's a next page to request.
  bool get hasNextPage => nextPageKey != null;
}

class _FirstPageStatusIndicatorBuilder extends StatelessWidget {
  const _FirstPageStatusIndicatorBuilder({
    required this.builder,
    this.shrinkWrap = false,
    Key? key,
  }) : super(key: key);

  final WidgetBuilder builder;
  final bool shrinkWrap;

  @override
  Widget build(BuildContext context) {
    if (shrinkWrap) {
      return SliverToBoxAdapter(
        child: builder(context),
      );
    } else {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: builder(context),
      );
    }
  }
}