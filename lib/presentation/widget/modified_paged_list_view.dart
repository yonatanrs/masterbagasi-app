import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:masterbagasi/presentation/widget/modifiedcustompagedview/modified_custom_paged_list_view.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';

import '../../misc/constant.dart';
import '../../misc/controllerstate/paging_controller_state.dart';
import '../../misc/itemtypelistinterceptor/default_item_type_list_interceptor.dart';
import '../../misc/itemtypelistinterceptor/item_type_list_interceptor.dart';
import '../../misc/paging/pagingcontrollerstatepagedchildbuilderdelegate/paging_controller_state_paged_child_builder_delegate.dart';

typedef OnProvidePagedChildBuilderDelegate<PageKeyType, ItemType> = PagedChildBuilderDelegate<ItemType> Function(PagingControllerState<PageKeyType, ItemType>?);

class ModifiedPagedListView<PageKeyType, ItemType> extends StatefulWidget {
  final bool visible;
  final bool pullToRefresh;
  final PagingControllerState<PageKeyType, ItemType>? pagingControllerState;
  final OnProvidePagedChildBuilderDelegate<PageKeyType, ItemType> onProvidePagedChildBuilderDelegate;
  late final ModifiedCustomPagedListView<PageKeyType, ItemType> pagedListView;
  final List<ItemTypeListInterceptor<ItemType>> itemTypeListInterceptorList = <ItemTypeListInterceptor<ItemType>>[
    DefaultItemTypeListInterceptor(
      padding: () => Constant.paddingListItem,
      itemSpacing: () => Constant.spacingListItem
    )
  ];

  PagedChildBuilderDelegate<ItemType> get builderDelegate => onProvidePagedChildBuilderDelegate(pagingControllerState);

  ModifiedPagedListView({
    Key? key,
    required this.visible,
    this.pullToRefresh = true,
    required PagingController<PageKeyType, ItemType> pagingController,
    required this.onProvidePagedChildBuilderDelegate,
    ScrollController? scrollController,
    Axis scrollDirection = Axis.vertical,
    bool reverse = false,
    bool? primary,
    ScrollPhysics? physics,
    bool shrinkWrap = false,
    EdgeInsetsGeometry? padding,
    double? itemExtent,
    bool addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
    bool addSemanticIndexes = true,
    double? cacheExtent,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    ScrollViewKeyboardDismissBehavior keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    String? restorationId,
    Clip clipBehavior = Clip.hardEdge,
    List<ItemTypeListInterceptor<ItemType>> itemTypeListInterceptorList = const []
  }) : pagingControllerState = null, super(key: key) {
    this.itemTypeListInterceptorList.addAll(itemTypeListInterceptorList);
    pagedListView = ModifiedCustomPagedListView(
      key: key,
      pagingController: pagingController,
      builderDelegate: onProvidePagedChildBuilderDelegate(null),
      scrollController: scrollController,
      scrollDirection: scrollDirection,
      reverse: reverse,
      primary: primary,
      physics: physics,
      shrinkWrap: shrinkWrap,
      padding: padding,
      itemExtent: itemExtent,
      addAutomaticKeepAlives: addAutomaticKeepAlives,
      addRepaintBoundaries: addRepaintBoundaries,
      addSemanticIndexes: addSemanticIndexes,
      cacheExtent: cacheExtent,
      dragStartBehavior: dragStartBehavior,
      keyboardDismissBehavior: keyboardDismissBehavior,
      restorationId: restorationId,
      clipBehavior: clipBehavior,
      itemTypeListInterceptorList: this.itemTypeListInterceptorList
    );
  }

  ModifiedPagedListView.fromPagingControllerState({
    Key? key,
    this.pullToRefresh = true,
    required PagingControllerState<PageKeyType, ItemType> pagingControllerState,
    required this.onProvidePagedChildBuilderDelegate,
    Axis scrollDirection = Axis.vertical,
    bool reverse = false,
    bool? primary,
    ScrollPhysics? physics,
    bool shrinkWrap = false,
    EdgeInsetsGeometry? padding,
    double? itemExtent,
    bool addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
    bool addSemanticIndexes = true,
    double? cacheExtent,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    ScrollViewKeyboardDismissBehavior keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    String? restorationId,
    Clip clipBehavior = Clip.hardEdge,
    List<ItemTypeListInterceptor<ItemType>> itemTypeListInterceptorList = const []
  }) : visible = pagingControllerState.isPagingControllerExist,
      // ignore: prefer_initializing_formals
      pagingControllerState = pagingControllerState,
      super(key: key)
  {
    this.itemTypeListInterceptorList.addAll(itemTypeListInterceptorList);
    pagedListView = ModifiedCustomPagedListView(
      key: key,
      pagingController: pagingControllerState.pagingController,
      builderDelegate: onProvidePagedChildBuilderDelegate(pagingControllerState),
      scrollController: pagingControllerState.scrollController,
      scrollDirection: scrollDirection,
      reverse: reverse,
      primary: primary,
      physics: physics,
      shrinkWrap: shrinkWrap,
      padding: padding,
      itemExtent: itemExtent,
      addAutomaticKeepAlives: addAutomaticKeepAlives,
      addRepaintBoundaries: addRepaintBoundaries,
      addSemanticIndexes: addSemanticIndexes,
      cacheExtent: cacheExtent,
      dragStartBehavior: dragStartBehavior,
      keyboardDismissBehavior: keyboardDismissBehavior,
      restorationId: restorationId,
      clipBehavior: clipBehavior,
      itemTypeListInterceptorList: this.itemTypeListInterceptorList
    );
  }

  @override
  _ModifiedPagedListViewState createState() => _ModifiedPagedListViewState();
}

class _ModifiedPagedListViewState<PageKeyType, ItemType> extends State<ModifiedPagedListView<PageKeyType, ItemType>> {
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    bool isPagingControllerStatePagedChildBuilderDelegate = widget.builderDelegate is PagingControllerStatePagedChildBuilderDelegate;
    assert(() {
      if (!(widget.pagingControllerState != null && isPagingControllerStatePagedChildBuilderDelegate)) {
        throw FlutterError('If builderDelegate is PagingControllerStatePagedChildBuilderDelegate then paging controller state must not be null...');
      }
      return true;
    }());
    return widget.visible ? NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (OverscrollIndicatorNotification overscroll) {
        overscroll.disallowIndicator();
        return false;
      },
      child: !widget.pagedListView.shrinkWrap ? SmartRefresher(
        enablePullDown: widget.pullToRefresh,
        controller: _refreshController,
        header: MaterialClassicHeader(color: Theme.of(context).colorScheme.primary),
        onRefresh: () {
          widget.pagedListView.pagingController.refresh();
          _refreshController.refreshCompleted();
        },
        child: widget.pagedListView
      ) : widget.pagedListView
    ) : Container();
  }
}