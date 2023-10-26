import '../paging/pagingresult/paging_data_result.dart';
import '../paging/pagingresult/paging_list_result.dart';
import '../paging/pagingresult/paging_result.dart';
import '../paging/pagingresult/paging_single_result.dart';

typedef MapPagingResultType<O, T> = O Function(T);

extension PagingSingleResultExt<T> on PagingSingleResult<T> {
  PagingSingleResult<O> map<O>(MapPagingResultType<O, T> onMap) {
    return PagingSingleResult<O>(
      item: onMap(item),
    );
  }
}

extension PagingResultObjectExt<T> on PagingResult<T> {
  void clearList() {
    if (this is PagingListResult<T>) {
      (this as PagingListResult<T>).itemList.clear();
    } else if (this is PagingDataResult<T>) {
      (this as PagingDataResult<T>).itemList.clear();
    }
  }

  List<T> getItemList() {
    if (this is PagingListResult<T>) {
      return (this as PagingListResult<T>).itemList;
    } else if (this is PagingDataResult<T>) {
      return (this as PagingDataResult<T>).itemList;
    } else {
      return [];
    }
  }
}

extension PagingListResultExt<T> on PagingListResult<T> {
  PagingListResult<O> map<O>(MapPagingResultType<O, T> onMap) {
    return PagingListResult<O>(
      itemList: itemList.map<O>((value) => onMap(value)).toList(),
    );
  }
}

extension PagingDataResultExt<T> on PagingDataResult<T> {
  PagingDataResult<O> map<O>(MapPagingResultType<O, T> onMap) {
    return PagingDataResult<O>(
      itemList: itemList.map<O>((value) => onMap(value)).toList(),
      page: page,
      totalPage: totalPage,
      totalItem: totalItem,
    );
  }
}

extension PagingResultExt<T> on T {
  PagingResult<O> toPagingResult<O>() {
    T value = this;
    late PagingResult<O> pagingResult;
    if (value is List<O>) {
      pagingResult = PagingListResult<O>(itemList: value);
    } else if (value is PagingResult<O>) {
      pagingResult = value;
    } else {
      pagingResult = PagingSingleResult<O>(item: value as O);
    }
    return pagingResult;
  }
}