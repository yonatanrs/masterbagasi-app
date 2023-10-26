import 'package:flutter/material.dart';

import '../../../misc/errorprovider/error_provider.dart';
import '../../../misc/load_data_result.dart';
import '../../../misc/defaultloaddataresultwidget/default_load_data_result_widget.dart';
import '../../../misc/injector.dart';
import 'base_load_data_result_implementer.dart';

typedef OnImplementLoadDataResultDirectly<T> = Widget Function(LoadDataResult<T>, ErrorProvider);
typedef OnImplementLoadDataResultDirectlyWithDefault<T> = Widget Function(LoadDataResult<T>, ErrorProvider, DefaultLoadDataResultWidget);

class LoadDataResultImplementerDirectly<T> extends BaseLoadDataResultImplementer<T> {
  final OnImplementLoadDataResultDirectly<T>? onImplementLoadDataResultDirectly;

  final DefaultLoadDataResultWidget? _defaultLoadDataResultWidget;

  @override
  DefaultLoadDataResultWidget get defaultLoadDataResultWidget => _defaultLoadDataResultWidget ?? Injector.locator<DefaultLoadDataResultWidget>();

  const LoadDataResultImplementerDirectly({
    Key? key,
    required LoadDataResult<T> loadDataResult,
    required ErrorProvider errorProvider,
    this.onImplementLoadDataResultDirectly,
    DefaultLoadDataResultWidget? defaultLoadDataResultWidget
  }) : _defaultLoadDataResultWidget = defaultLoadDataResultWidget, super(
    key: key,
    loadDataResult: loadDataResult,
    errorProvider: errorProvider
  );

  @override
  Widget build(BuildContext context) {
    if (onImplementLoadDataResultDirectly != null) {
      return onImplementLoadDataResultDirectly!(loadDataResult, errorProvider);
    } else {
      return Container();
    }
  }
}

class LoadDataResultImplementerDirectlyWithDefault<T> extends LoadDataResultImplementerDirectly<T> {
  final OnImplementLoadDataResultDirectlyWithDefault<T>? onImplementLoadDataResultDirectlyWithDefault;

  @override
  OnImplementLoadDataResultDirectly<T>? get onImplementLoadDataResultDirectly {
    return onImplementLoadDataResultDirectlyWithDefault != null
      ? (loadDataResult, errorProvider) => onImplementLoadDataResultDirectlyWithDefault!(loadDataResult, errorProvider, defaultLoadDataResultWidget)
      : null;
  }

  const LoadDataResultImplementerDirectlyWithDefault({
    Key? key,
    required LoadDataResult<T> loadDataResult,
    required ErrorProvider errorProvider,
    this.onImplementLoadDataResultDirectlyWithDefault,
    DefaultLoadDataResultWidget? defaultLoadDataResultWidget
  }) : super(
    key: key,
    loadDataResult: loadDataResult,
    errorProvider: errorProvider,
    defaultLoadDataResultWidget: defaultLoadDataResultWidget
  );
}