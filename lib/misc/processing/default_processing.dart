import 'processing.dart';

class DefaultProcessing<T> extends Processing<T> {
  T result;

  DefaultProcessing(this.result) : super();
}