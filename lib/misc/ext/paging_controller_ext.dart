import 'package:dio/dio.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:masterbagasi/misc/ext/load_data_result_ext.dart';

import '../additionalloadingindicatorchecker/additional_paging_result_parameter_checker.dart';
import '../load_data_result.dart';
import '../paging/modified_paging_controller.dart';
import '../paging/pagingresult/paging_data_result.dart';
import '../paging/pagingresult/paging_list_result.dart';
import '../paging/pagingresult/paging_result.dart';
import '../paging/pagingresult/paging_result_with_parameter.dart';

typedef PageRequestListenerForLoadDataResult<PageKeyType, ItemType> = Future<LoadDataResult<PagingResult<ItemType>>> Function(PageKeyType pageKey);
typedef PageRequestListenerWithItemListForLoadDataResult<PageKeyType, ItemType> = Future<LoadDataResult<PagingResult<ItemType>>> Function(PageKeyType pageKey, List<ItemType>? itemList);
typedef OnPageKeyNext<PageKeyType> = PageKeyType Function(PageKeyType);

extension PagingControllerExt<PageKeyType, ItemType> on PagingController<PageKeyType, ItemType> {
  void addPageRequestListenerForLoadDataResult({
    required PageRequestListenerForLoadDataResult<PageKeyType, ItemType> listener,
    required OnPageKeyNext<PageKeyType> onPageKeyNext
  }) {
    _rawAddPageRequestListenerWithItemListForLoadDataResult(
      listener: (pageKey, itemList) => listener(pageKey),
      onPageKeyNext: onPageKeyNext
    );
  }

  void addPageRequestListenerWithItemListForLoadDataResult({
    required PageRequestListenerWithItemListForLoadDataResult<PageKeyType, ItemType> listener,
    required OnPageKeyNext<PageKeyType> onPageKeyNext
  }) {
    _rawAddPageRequestListenerWithItemListForLoadDataResult(
      listener: listener,
      onPageKeyNext: onPageKeyNext
    );
  }

  void _rawAddPageRequestListenerWithItemListForLoadDataResult({
    required PageRequestListenerWithItemListForLoadDataResult<PageKeyType, ItemType> listener,
    required OnPageKeyNext<PageKeyType> onPageKeyNext
  }) {
    addPageRequestListener((pageKey) async {
      LoadDataResult<PagingResult<ItemType>> loadDataResult;
      try {
        loadDataResult = await listener(pageKey, itemList);
      } catch(e) {
        loadDataResult = FailedLoadDataResult(e: e);
      }
      if (loadDataResult is SuccessLoadDataResult) {
        PagingResult<ItemType> resultValue = (loadDataResult as SuccessLoadDataResult<PagingResult<ItemType>>).value;
        PagingResultParameter<ItemType>? pagingResultParameter;
        while (true) {
          if (resultValue is PagingDataResult<ItemType>) {
            if (resultValue.page == resultValue.totalPage) {
              if (this is ModifiedPagingController<PageKeyType, ItemType>) {
                ModifiedPagingController<PageKeyType, ItemType> modifiedPagingController = this as ModifiedPagingController<PageKeyType, ItemType>;
                if (resultValue.itemList.isNotEmpty) {
                  modifiedPagingController.appendLastPageWithCurrentPageKey(resultValue.itemList, pageKey, pagingResultParameter);
                } else {
                  modifiedPagingController.updateLastPageWithCurrentPageKey(pageKey, pagingResultParameter);
                }
              } else {
                appendLastPage(resultValue.itemList);
              }
            } else {
              if (this is ModifiedPagingController<PageKeyType, ItemType>) {
                ModifiedPagingController<PageKeyType, ItemType> modifiedPagingController = this as ModifiedPagingController<PageKeyType, ItemType>;
                if (resultValue.itemList.isNotEmpty) {
                  modifiedPagingController.appendPageWithCurrentPageKey(resultValue.itemList, pageKey, onPageKeyNext(pageKey), pagingResultParameter);
                } else {
                  modifiedPagingController.updatePageWithCurrentPageKey(pageKey, onPageKeyNext(pageKey), pagingResultParameter);
                }
              } else {
                appendPage(resultValue.itemList, onPageKeyNext(pageKey));
              }
            }
          } else if (resultValue is PagingListResult<ItemType>) {
            if (this is ModifiedPagingController<PageKeyType, ItemType>) {
              (this as ModifiedPagingController<PageKeyType, ItemType>).appendLastPageWithCurrentPageKey(resultValue.itemList, pageKey, pagingResultParameter);
            } else {
              appendLastPage(resultValue.itemList);
            }
          } else if (resultValue is PagingResultWithParameter<ItemType>) {
            pagingResultParameter = resultValue.pagingResultParameter;
            resultValue = resultValue.pagingResult;
            continue;
          }
          break;
        }
      } else if (loadDataResult is FailedLoadDataResult) {
        FailedLoadDataResult failedLoadDataResult = loadDataResult as FailedLoadDataResult;
        if (failedLoadDataResult.isFailedBecauseCancellation) {
          return;
        }
        error = failedLoadDataResult.e;
      }
    });
  }
}