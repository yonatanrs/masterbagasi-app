import 'package:flutter/foundation.dart';

abstract class LoadDataResult<T> { }

class NoLoadDataResult<T> extends LoadDataResult<T> { }

class IsLoadingLoadDataResult<T> extends LoadDataResult<T> { }

class SuccessLoadDataResult<T> extends LoadDataResult<T> {
  T value;

  SuccessLoadDataResult({required this.value});
}

class FailedLoadDataResult<T> extends LoadDataResult<T> {
  dynamic e;
  StackTrace? stackTrace;

  static FailedLoadDataResult<T>? throwException<T>(void Function() onThrowException) {
    try {
      onThrowException();
      return null;
    } catch (e, stackTrace) {
      return FailedLoadDataResult<T>(e: e, stackTrace: stackTrace);
    }
  }

  FailedLoadDataResult({required this.e, this.stackTrace}) {
    if (kDebugMode) {
      print(e);
      print(stackTrace);
    }
  }
}

class LoadDataResultWrapper<T> {
  LoadDataResult<T> loadDataResult;

  LoadDataResultWrapper(this.loadDataResult);
}