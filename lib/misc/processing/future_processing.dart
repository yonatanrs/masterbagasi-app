import '../ext/future_ext.dart';
import '../load_data_result.dart';
import 'processing.dart';

typedef _FutureFunction<T> = Future<T> Function({dynamic parameter});

class FutureProcessing<T> extends Processing<T> {
  final _FutureFunction<T> _future;

  FutureProcessing(
    // ignore: library_private_types_in_public_api
    _FutureFunction<T> future,
  ) : _future = future, super();

  Future<T> future({dynamic parameter}) async {
    try {
      return await _future(parameter: parameter);
    } catch (e) {
      rethrow;
    }
  }
}

extension FutureProcessingExt<T> on FutureProcessing<T> {
  FutureProcessing<O> map<O>({MapResultType<O, T>? onMap}) {
    return FutureProcessing<O>(
      ({parameter}) => _future(parameter: parameter).map(onMap: onMap),
    );
  }

  FutureProcessing<LoadDataResult<O>> mapToLoadDataResult<O>({MapResultType<O, T>? onMapToLoadDataResult}) {
    return FutureProcessing<LoadDataResult<O>>(
      ({parameter}) => _future(parameter: parameter).getLoadDataResult(mapLoadDataResult: onMapToLoadDataResult),
    );
  }
}