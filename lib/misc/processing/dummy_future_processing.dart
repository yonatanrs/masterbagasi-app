import 'package:dio/dio.dart';

import 'future_processing.dart';

class DummyFutureProcessing<T> extends FutureProcessing<T> {
  DummyFutureProcessing(
    Future<T> Function(CancelToken) loadDataResultFuture
  ): super(({parameter}) {
    return Future.any([
      if (parameter is CancelToken) parameter.whenCancel.then((e) => throw e),
      loadDataResultFuture(parameter)
    ]);
  });
}