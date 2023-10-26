import 'package:masterbagasi/misc/ext/paging_ext.dart';

import '../error/load_data_result_error.dart';
import '../load_data_result.dart';
import '../paging/pagingresult/paging_result.dart';
import 'load_data_result_ext.dart';

typedef MapResultType<O, T> = O Function(T);

extension FutureExt<T> on Future<T> {
  Future<O> map<O>({MapResultType<O, T>? onMap}) {
    return then<O>((value) {
      if (onMap != null) {
        return onMap(value);
      } else {
        return value as O;
      }
    });
  }

  Future<LoadDataResult<O>> getLoadDataResult<O>({MapLoadDataResultType<O, T>? mapLoadDataResult}) {
    return then<LoadDataResult<O>>((value) {
      if (mapLoadDataResult != null) {
        return SuccessLoadDataResult(value: mapLoadDataResult(value));
      } else {
        if (value is SuccessLoadDataResult) {
          return SuccessLoadDataResult(value: value.value as O);
        } else if (value is FailedLoadDataResult) {
          throw value.e;
        } else {
          return SuccessLoadDataResult(value: value as O);
        }
      }
    }).catchError((e, stackTrace) => FailedLoadDataResult<O>(e: e, stackTrace: stackTrace));
  }
}

extension LoadDataResultFutureExt<T> on Future<LoadDataResult<T>> {
  Future<LoadDataResult<O>> map<O>(MapLoadDataResultType<O, T> onMap) {
    return then<LoadDataResult<O>>((loadDataResult) {
      return loadDataResult.map(onMap);
    }).catchError((e, stackTrace) => FailedLoadDataResult<O>(e: e, stackTrace: stackTrace));
  }

  Future<LoadDataResult<PagingResult<O>>> toPagingResult<O>() {
    return map<PagingResult<O>>((value) => value.toPagingResult<O>());
  }
}