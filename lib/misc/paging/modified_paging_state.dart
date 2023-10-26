import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'pagingresult/paging_result_with_parameter.dart';

class ModifiedPagingState<PageKeyType, ItemType> extends PagingState<PageKeyType, ItemType> {
  final dynamic errorFirstPageOuterProcess;
  final PagingResultParameter<ItemType>? pagingResultParameter;
  final bool hasTriggerLoader;
  final ForceModifiedPagingStateNotifyToPagingStateValueNotifier? forceModifiedPagingStateNotifyToPagingStateValueNotifier;

  const ModifiedPagingState({
    PageKeyType? nextPageKey,
    List<ItemType>? itemList,
    this.pagingResultParameter,
    dynamic error,
    this.errorFirstPageOuterProcess,
    this.hasTriggerLoader = true,
    this.forceModifiedPagingStateNotifyToPagingStateValueNotifier
  }) : super(
    nextPageKey: nextPageKey,
    itemList: itemList,
    error: error
  );

  @override
  PagingStatus get status {
    if (errorFirstPageOuterProcess != null) {
      return PagingStatus.firstPageError;
    }
    return super.status;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is ModifiedPagingState) {
      return other.itemList == itemList &&
        other.error == error &&
        other.pagingResultParameter == pagingResultParameter &&
        other.hasTriggerLoader == hasTriggerLoader &&
        other.nextPageKey == nextPageKey &&
        other.errorFirstPageOuterProcess == errorFirstPageOuterProcess &&
        other.forceModifiedPagingStateNotifyToPagingStateValueNotifier == forceModifiedPagingStateNotifyToPagingStateValueNotifier;
    } else {
      return false;
    }
  }

  @override
  int get hashCode => super.hashCode ^ pagingResultParameter.hashCode ^ hasTriggerLoader.hashCode ^ errorFirstPageOuterProcess.hashCode ^ forceModifiedPagingStateNotifyToPagingStateValueNotifier.hashCode;
}

class ForceModifiedPagingStateNotifyToPagingStateValueNotifier {}