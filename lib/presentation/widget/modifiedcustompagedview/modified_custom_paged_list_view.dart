import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../misc/itemtypelistinterceptor/item_type_list_interceptor.dart';
import '../../../misc/itemtypelistinterceptor/item_type_list_interceptor_parameter.dart';
import '../../../misc/itemtypelistinterceptor/item_type_list_interceptor_result.dart';
import '../../../misc/paging/modified_paging_state.dart';
import '../../../misc/paging/pagingresult/paging_result_with_parameter.dart';
import 'modified_custom_paged_sliver_list.dart';

class ModifiedCustomPagedListView<PageKeyType, ItemType> extends CustomScrollView {
  final bool _shrinkWrapFirstPageIndicators;
  final IndexedWidgetBuilder? _separatorBuilder;
  final List<ItemTypeListInterceptor<ItemType>> itemTypeListInterceptorList;
  final PagingController<PageKeyType, ItemType> pagingController;
  final PagedChildBuilderDelegate<ItemType> builderDelegate;
  final bool addAutomaticKeepAlives;
  final bool addRepaintBoundaries;
  final bool addSemanticIndexes;
  final double? itemExtent;

  const ModifiedCustomPagedListView({
    required this.pagingController,
    required this.builderDelegate,
    ScrollController? scrollController,
    Axis scrollDirection = Axis.vertical,
    bool reverse = false,
    bool? primary,
    ScrollPhysics? physics,
    bool shrinkWrap = false,
    EdgeInsetsGeometry? padding,
    this.itemExtent,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    double? cacheExtent,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    ScrollViewKeyboardDismissBehavior keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    String? restorationId,
    Clip clipBehavior = Clip.hardEdge,
    required this.itemTypeListInterceptorList,
    Key? key,
  }) : _separatorBuilder = null,
      _shrinkWrapFirstPageIndicators = shrinkWrap,
      super(
        scrollDirection: scrollDirection,
        reverse: reverse,
        primary: primary,
        physics: physics,
        shrinkWrap: shrinkWrap,
        cacheExtent: cacheExtent,
        dragStartBehavior: dragStartBehavior,
        keyboardDismissBehavior: keyboardDismissBehavior,
        restorationId: restorationId,
        clipBehavior: clipBehavior,
        key: key,
      );

  @override
  List<Widget> buildSlivers(BuildContext context) {
    // List<ItemType> additionalItemList = [];
    // PagingState<PageKeyType, ItemType> pagingState = pagingController.value;
    // if (pagingState is ModifiedPagingState<PageKeyType, ItemType>) {
    //   PagingResultParameter<ItemType>? pagingResultParameter = pagingState.pagingResultParameter;
    //   if (pagingResultParameter != null) {
    //     List<ItemType>? receivedAdditionalItemList = pagingResultParameter.additionalItemList;
    //     if (receivedAdditionalItemList != null) {
    //       additionalItemList = receivedAdditionalItemList;
    //     }
    //   }
    // }
    // ItemTypeListInterceptorResult<ItemType> itemTypeListInterceptorResult = _interceptListItem(pagingController.itemList ?? [], additionalItemList);
    final separatorBuilder = _separatorBuilder;
    Widget resultWidget = separatorBuilder != null ? ModifiedCustomPagedSliverList<PageKeyType, ItemType>.separated(
      builderDelegate: builderDelegate,
      pagingController: pagingController,
      separatorBuilder: separatorBuilder,
      addAutomaticKeepAlives: addAutomaticKeepAlives,
      addRepaintBoundaries: addRepaintBoundaries,
      addSemanticIndexes: addSemanticIndexes,
      itemExtent: itemExtent,
      shrinkWrapFirstPageIndicators: _shrinkWrapFirstPageIndicators,
      itemTypeListInterceptorList: itemTypeListInterceptorList,
    ) : ModifiedCustomPagedSliverList<PageKeyType, ItemType>(
      builderDelegate: builderDelegate,
      pagingController: pagingController,
      addAutomaticKeepAlives: addAutomaticKeepAlives,
      addRepaintBoundaries: addRepaintBoundaries,
      addSemanticIndexes: addSemanticIndexes,
      itemExtent: itemExtent,
      shrinkWrapFirstPageIndicators: _shrinkWrapFirstPageIndicators,
      itemTypeListInterceptorList: itemTypeListInterceptorList,
    );
    return <Widget>[
      resultWidget,
    ];
  }
}
