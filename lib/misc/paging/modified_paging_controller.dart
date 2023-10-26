import 'package:flutter/material.dart';
import 'package:masterbagasi/misc/manager/api_request_manager.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../additionalloadingindicatorchecker/additional_paging_result_parameter_checker.dart';
import '../controllerstate/listitemcontrollerstate/page_keyed_list_item_controller_state.dart';
import 'appendpagenewitemsinterceptor/append_page_new_items_interceptor.dart';
import 'appendpagenewitemsinterceptor/default_append_page_new_items_interceptor.dart';
import 'modified_paging_state.dart';
import 'pagingresult/paging_result_with_parameter.dart';

class ModifiedPagingController<PageKeyType, ItemType> extends PagingController<PageKeyType, ItemType> {
  final ApiRequestManager apiRequestManager;
  final String? subKey;
  final List<AppendPageNewItemsInterceptor<PageKeyType, ItemType>> appendPageNewItemsInterceptorList = [
    DefaultAppendPageNewItemsInterceptor<PageKeyType, ItemType>()
  ];
  final AdditionalPagingResultParameterChecker<PageKeyType, ItemType>? additionalPagingResultParameterChecker;

  @override
  set value(PagingState<PageKeyType, ItemType> newValue) {
    if (newValue is ModifiedPagingState<PageKeyType, ItemType>) {
      super.value = ModifiedPagingState<PageKeyType, ItemType>(
        nextPageKey: newValue.nextPageKey,
        itemList: newValue.itemList,
        error: newValue.error,
        errorFirstPageOuterProcess: newValue.errorFirstPageOuterProcess,
        pagingResultParameter: newValue.pagingResultParameter,
        hasTriggerLoader: newValue.hasTriggerLoader,
        forceModifiedPagingStateNotifyToPagingStateValueNotifier: newValue.forceModifiedPagingStateNotifyToPagingStateValueNotifier
      );
    } else {
      super.value = ModifiedPagingState<PageKeyType, ItemType>(
        nextPageKey: newValue.nextPageKey,
        itemList: newValue.itemList,
        error: newValue.error,
        errorFirstPageOuterProcess: null,
        pagingResultParameter: null,
        forceModifiedPagingStateNotifyToPagingStateValueNotifier: null
      );
    }
  }

  ModifiedPagingController({
    required PageKeyType firstPageKey,
    this.subKey,
    int? invisibleItemsThreshold,
    List<AppendPageNewItemsInterceptor<PageKeyType, ItemType>> appendPageNewItemsInterceptorList = const [],
    required this.apiRequestManager,
    this.additionalPagingResultParameterChecker
  }) : super(
    firstPageKey: firstPageKey,
    invisibleItemsThreshold: invisibleItemsThreshold,
  ) {
    this.appendPageNewItemsInterceptorList.addAll(appendPageNewItemsInterceptorList);
  }

  void resetToDesiredPageKey(PageKeyType? pageKey) {
    apiRequestManager.cancelAllDesiredPageKeyedRequest(pageKey, subKey: subKey);
    final previousItems = value.itemList ?? [];
    final itemList = previousItems.where((item) {
      if (item is PageKeyedListItemControllerState) {
        if (item.pageKey is int && pageKey is int) {
          return item.pageKey < pageKey;
        } else {
          return true;
        }
      } else {
        return true;
      }
    }).toList();
    AdditionalPagingResultParameterChecker<PageKeyType, ItemType>? currentAdditionalPagingResultParameterChecker = additionalPagingResultParameterChecker;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      value = ModifiedPagingState<PageKeyType, ItemType>(
        error: null,
        itemList: itemList.isEmpty ? null : itemList,
        nextPageKey: pageKey,
        pagingResultParameter: currentAdditionalPagingResultParameterChecker?.getAdditionalPagingResultParameter(
          AdditionalPagingResultCheckerParameter<PageKeyType, ItemType>(page: pageKey)
        )
      );
    });
  }

  @override
  void refresh() {
    apiRequestManager.cancelAllDesiredPageKeyedRequest(firstPageKey, subKey: subKey);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      value = ModifiedPagingState<PageKeyType, ItemType>(
        nextPageKey: firstPageKey,
        error: null,
        itemList: null,
        forceModifiedPagingStateNotifyToPagingStateValueNotifier: ForceModifiedPagingStateNotifyToPagingStateValueNotifier()
      );
    });
  }

  void appendPageWithPagingResultParameter(List<ItemType> newItems, PageKeyType? nextPageKey, PagingResultParameter<ItemType>? pagingResultParameter) {
    final previousItems = value.itemList ?? [];
    final itemList = previousItems + newItems;
    if (pagingResultParameter == null) {
      value = PagingState<PageKeyType, ItemType>(
        itemList: itemList,
        error: null,
        nextPageKey: nextPageKey,
      );
    } else {
      value = ModifiedPagingState<PageKeyType, ItemType>(
        itemList: itemList,
        error: null,
        nextPageKey: nextPageKey,
        pagingResultParameter: pagingResultParameter
      );
    }
  }

  void appendLastPageWithPagingResultParameter(List<ItemType> newItems, PagingResultParameter<ItemType>? pagingResultParameter) {
    appendPageWithPagingResultParameter(newItems, null, pagingResultParameter);
  }

  void updatePage(PageKeyType? nextPageKey, PagingResultParameter<ItemType>? pagingResultParameter) {
    final previousItems = value.itemList ?? [];
    if (pagingResultParameter == null) {
      value = PagingState<PageKeyType, ItemType>(
        itemList: previousItems,
        error: null,
        nextPageKey: nextPageKey,
      );
    } else {
      value = ModifiedPagingState<PageKeyType, ItemType>(
        itemList: previousItems,
        error: null,
        nextPageKey: nextPageKey,
        pagingResultParameter: pagingResultParameter
      );
    }
  }

  @override
  set error(dynamic newError) {
    if (newError != null) {
      value = PagingState<PageKeyType, ItemType>(
        error: newError,
        itemList: itemList,
        nextPageKey: nextPageKey,
      );
    } else {
      resetToDesiredPageKey(nextPageKey);
    }
  }

  set errorFirstPageOuterProcess(dynamic newError) {
    value = ModifiedPagingState<PageKeyType, ItemType>(
      error: error,
      itemList: itemList,
      nextPageKey: nextPageKey,
      errorFirstPageOuterProcess: newError,
      pagingResultParameter: pagingResultParameter
    );
  }

  dynamic get errorFirstPageOuterProcess {
    if (value is ModifiedPagingState<PageKeyType, ItemType>) {
      return (value as ModifiedPagingState<PageKeyType, ItemType>).errorFirstPageOuterProcess;
    } else {
      return value.error;
    }
  }

  set pagingResultParameter(PagingResultParameter<ItemType>? pagingResultParameter) {
    value = ModifiedPagingState<PageKeyType, ItemType>(
      error: error,
      errorFirstPageOuterProcess: errorFirstPageOuterProcess,
      itemList: itemList,
      nextPageKey: nextPageKey,
      pagingResultParameter: pagingResultParameter,
    );
  }

  PagingResultParameter<ItemType>? get pagingResultParameter {
    if (value is ModifiedPagingState<PageKeyType, ItemType>) {
      return (value as ModifiedPagingState<PageKeyType, ItemType>).pagingResultParameter;
    } else {
      return null;
    }
  }

  void appendPageWithCurrentPageKey(List<ItemType> newItems, PageKeyType? currentPageKey, PageKeyType? nextPageKey, PagingResultParameter<ItemType>? pagingResultParameter) {
    appendPageWithPagingResultParameter(_interceptAppendPageNewItems(newItems, currentPageKey), nextPageKey, pagingResultParameter);
    checkLoaderIndicatorInLoadedPageKey(nextPageKey);
  }

  void updatePageWithCurrentPageKey(PageKeyType? currentPageKey, PageKeyType? nextPageKey, PagingResultParameter<ItemType>? pagingResultParameter) {
    updatePage(nextPageKey, pagingResultParameter);
    checkLoaderIndicatorInLoadedPageKey(nextPageKey);
  }

  void appendLastPageWithCurrentPageKey(List<ItemType> newItems, PageKeyType? currentPageKey, PagingResultParameter<ItemType>? pagingResultParameter) {
    appendLastPageWithPagingResultParameter(_interceptAppendPageNewItems(newItems, currentPageKey), pagingResultParameter);
  }

  void updateLastPageWithCurrentPageKey(PageKeyType? currentPageKey, PagingResultParameter<ItemType>? pagingResultParameter) {
    updatePage(null, pagingResultParameter);
  }

  PagingResultParameter<ItemType>? getLoaderIndicatorInLoadedPageKey(PageKeyType? loadedPageKey) {
    AdditionalPagingResultParameterChecker<PageKeyType, ItemType>? currentAdditionalPagingResultParameterChecker = additionalPagingResultParameterChecker;
    return currentAdditionalPagingResultParameterChecker?.getAdditionalPagingResultParameter(
      AdditionalPagingResultCheckerParameter<PageKeyType, ItemType>(page: loadedPageKey)
    );
  }

  void checkLoaderIndicatorInLoadedPageKey(PageKeyType? loadedPageKey) {
    pagingResultParameter ??= getLoaderIndicatorInLoadedPageKey(loadedPageKey);
  }

  List<ItemType> _interceptAppendPageNewItems(List<ItemType> newItems, PageKeyType? nextPageKey) {
    int length = appendPageNewItemsInterceptorList.length;
    if (length == 0) {
      return newItems;
    }
    int i = 0;
    List<ItemType> itemList = [];
    while (i < length) {
      itemList = appendPageNewItemsInterceptorList[i].intercept(newItems, nextPageKey);
      i += 1;
    }
    return itemList;
  }
}