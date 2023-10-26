import 'package:dio/dio.dart';
import 'future_processing.dart';

class DioHttpClientProcessing<T> extends FutureProcessing<T> {
  DioHttpClientProcessing(
    Future<T> Function(CancelToken) loadDataResultFuture
  ): super(({parameter}) => loadDataResultFuture(parameter));
}