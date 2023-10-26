import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class PagingControllerState<PageKeyType, ItemType> {
  PagingController<PageKeyType, ItemType> pagingController;
  ScrollController? scrollController;
  bool isPagingControllerExist;

  PagingControllerState({
    required this.pagingController,
    this.scrollController,
    required this.isPagingControllerExist
  });

  PagingControllerState<PageKeyType, ItemType> copy({
    PagingController<PageKeyType, ItemType>? pagingController,
    ScrollController? scrollController,
    bool? isPagingControllerExist
  }) {
    return PagingControllerState(
      pagingController: pagingController ?? this.pagingController,
      scrollController: scrollController ?? this.scrollController,
      isPagingControllerExist: isPagingControllerExist ?? this.isPagingControllerExist
    );
  }
}