import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../misc/itemtypelistinterceptor/item_type_list_interceptor.dart';
import '../../../misc/itemtypelistinterceptor/item_type_list_interceptor_result.dart';
import 'modified_custom_appended_sliver_child_builder_delegate.dart';
import 'modified_custom_paged_sliver_builder.dart';

class ModifiedCustomPagedSliverList<PageKeyType, ItemType> extends PagedSliverList<PageKeyType, ItemType> {
  final IndexedWidgetBuilder? _separatorBuilder;
  final List<ItemTypeListInterceptor<ItemType>> itemTypeListInterceptorList;

  const ModifiedCustomPagedSliverList({
    required PagingController<PageKeyType, ItemType> pagingController,
    required PagedChildBuilderDelegate<ItemType> builderDelegate,
    bool addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
    bool addSemanticIndexes = true,
    double? itemExtent,
    SemanticIndexCallback? semanticIndexCallback,
    bool shrinkWrapFirstPageIndicators = false,
    Key? key,
    required this.itemTypeListInterceptorList,
  }) : _separatorBuilder = null,
      super(
        pagingController: pagingController,
        builderDelegate: builderDelegate,
        addAutomaticKeepAlives: addAutomaticKeepAlives,
        addRepaintBoundaries: addRepaintBoundaries,
        addSemanticIndexes: addSemanticIndexes,
        itemExtent: itemExtent,
        semanticIndexCallback: semanticIndexCallback,
        shrinkWrapFirstPageIndicators: shrinkWrapFirstPageIndicators,
        key: key
      );

  const ModifiedCustomPagedSliverList.separated({
    required PagingController<PageKeyType, ItemType> pagingController,
    required PagedChildBuilderDelegate<ItemType> builderDelegate,
    required IndexedWidgetBuilder separatorBuilder,
    bool addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
    bool addSemanticIndexes = true,
    double? itemExtent,
    SemanticIndexCallback? semanticIndexCallback,
    bool shrinkWrapFirstPageIndicators = false,
    Key? key,
    required this.itemTypeListInterceptorList,
  }) : _separatorBuilder = null,
      super(
        pagingController: pagingController,
        builderDelegate: builderDelegate,
        addAutomaticKeepAlives: addAutomaticKeepAlives,
        addRepaintBoundaries: addRepaintBoundaries,
        addSemanticIndexes: addSemanticIndexes,
        itemExtent: itemExtent,
        semanticIndexCallback: semanticIndexCallback,
        shrinkWrapFirstPageIndicators: shrinkWrapFirstPageIndicators,
        key: key
      );

  @override
  Widget build(BuildContext context) => ModifiedCustomPagedSliverBuilder<PageKeyType, ItemType>(
    pagingController: pagingController,
    builderDelegate: builderDelegate,
    modifiedCompletedListingBuilder: (
      context,
      showOriginalLoaderIndicator,
      itemBuilder,
      additionalItemBuilder,
      itemCount,
      additionalItemCount,
      noMoreItemsIndicatorBuilder,
    ) => _buildSliverList(
      showOriginalLoaderIndicator,
      itemBuilder,
      itemCount,
      additionalItemBuilder,
      additionalItemCount,
      statusIndicatorBuilder: noMoreItemsIndicatorBuilder,
    ),
    // This widget using builder to differentiate between first loading listing and normal loading listing.
    // There is a bug where using same widget because first loading listing and normal loading listing widget has similar widget (sliver list) before.
    modifiedFirstLoadingListingBuilder: (
      context,
      showOriginalLoaderIndicator,
      itemBuilder,
      additionalItemBuilder,
      itemCount,
      additionalItemCount,
      progressIndicatorBuilder,
    ) => Builder(
      builder: (context) {
        return _buildSliverList(
          showOriginalLoaderIndicator,
          itemBuilder,
          itemCount,
          additionalItemBuilder,
          additionalItemCount,
          statusIndicatorBuilder: progressIndicatorBuilder,
        );
      }
    ),
    modifiedLoadingListingBuilder: (
      context,
      showOriginalLoaderIndicator,
      itemBuilder,
      additionalItemBuilder,
      itemCount,
      additionalItemCount,
      progressIndicatorBuilder,
    ) => _buildSliverList(
      showOriginalLoaderIndicator,
      itemBuilder,
      itemCount,
      additionalItemBuilder,
      additionalItemCount,
      statusIndicatorBuilder: progressIndicatorBuilder,
    ),
    modifiedErrorListingBuilder: (
      context,
      showOriginalLoaderIndicator,
      itemBuilder,
      additionalItemBuilder,
      itemCount,
      additionalItemCount,
      errorIndicatorBuilder,
    ) => _buildSliverList(
      showOriginalLoaderIndicator,
      itemBuilder,
      itemCount,
      additionalItemBuilder,
      additionalItemCount,
      statusIndicatorBuilder: errorIndicatorBuilder,
    ),
    shrinkWrapFirstPageIndicators: shrinkWrapFirstPageIndicators,
    itemTypeListInterceptorList: itemTypeListInterceptorList,
  );

  SliverMultiBoxAdaptorWidget _buildSliverList(
    bool showOriginalLoaderIndicator,
    IndexedWidgetBuilder itemBuilder,
    int itemCount,
    IndexedWidgetBuilder additionalItemBuilder,
    int additionalItemCount,
    {WidgetBuilder? statusIndicatorBuilder, Key? key}
  ) {
    final delegate = _buildSliverDelegate(
      showOriginalLoaderIndicator,
      itemBuilder,
      itemCount,
      additionalItemBuilder,
      additionalItemCount,
      statusIndicatorBuilder: statusIndicatorBuilder,
    );

    final itemExtent = this.itemExtent;

    return (itemExtent == null || _separatorBuilder != null) ? SliverList(
      key: key,
      delegate: delegate,
    ) : SliverFixedExtentList(
      key: key,
      delegate: delegate,
      itemExtent: itemExtent,
    );
  }

  SliverChildBuilderDelegate _buildSliverDelegate(
    bool showOriginalLoaderIndicator,
    IndexedWidgetBuilder itemBuilder,
    int itemCount,
    IndexedWidgetBuilder additionalItemBuilder,
    int additionalItemCount,
    {WidgetBuilder? statusIndicatorBuilder}
  ) {
    final separatorBuilder = _separatorBuilder;
    return separatorBuilder == null ? ModifiedCustomAppendedSliverChildBuilderDelegate(
      showOriginalLoaderIndicator: showOriginalLoaderIndicator,
      builder: itemBuilder,
      childCount: itemCount,
      additionalBuilder: additionalItemBuilder,
      additionalChildCount: additionalItemCount,
      appendixBuilder: statusIndicatorBuilder,
      addAutomaticKeepAlives: addAutomaticKeepAlives,
      addRepaintBoundaries: addRepaintBoundaries,
      addSemanticIndexes: addSemanticIndexes,
      semanticIndexCallback: semanticIndexCallback,
    ) : ModifiedCustomAppendedSliverChildBuilderDelegate.separated(
      showOriginalLoaderIndicator: showOriginalLoaderIndicator,
      builder: itemBuilder,
      childCount: itemCount,
      additionalBuilder: additionalItemBuilder,
      additionalChildCount: additionalItemCount,
      appendixBuilder: statusIndicatorBuilder,
      separatorBuilder: separatorBuilder,
      addAutomaticKeepAlives: addAutomaticKeepAlives,
      addRepaintBoundaries: addRepaintBoundaries,
      addSemanticIndexes: addSemanticIndexes,
    );
  }
}