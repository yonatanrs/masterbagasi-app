import 'package:flutter/material.dart';

import '../../../misc/errorprovider/error_provider.dart';
import '../../../misc/load_data_result.dart';
import '../../../misc/widget_helper.dart';
import '../../../misc/defaultloaddataresultwidget/default_load_data_result_widget.dart';
import '../../../misc/injector.dart';
import '../../widget/modified_loading_indicator.dart';
import 'base_load_data_result_implementer.dart';

typedef OnIsLoadingLoadDataResultWidget = Widget Function(Widget);
typedef OnSuccessLoadDataResultWidget<T> = Widget Function(T);
typedef OnFailedLoadDataResultWidget = Widget Function(ErrorProvider, dynamic, Widget);
typedef OnNoLoadingLoadDataResultWidget = Widget Function();

class LoadDataResultImplementer<T> extends BaseLoadDataResultImplementer<T> {
  final OnIsLoadingLoadDataResultWidget? onIsLoadingLoadDataResultWidget;
  final OnSuccessLoadDataResultWidget<T>? onSuccessLoadDataResultWidget;
  final OnFailedLoadDataResultWidget? onFailedLoadDataResultWidget;
  final OnNoLoadingLoadDataResultWidget? onNoLoadingLoadDataResultWidget;

  final DefaultLoadDataResultWidget? _defaultLoadDataResultWidget;

  @override
  DefaultLoadDataResultWidget get defaultLoadDataResultWidget => _defaultLoadDataResultWidget ?? Injector.locator<DefaultLoadDataResultWidget>();

  const LoadDataResultImplementer({
    Key? key,
    required LoadDataResult<T> loadDataResult,
    required ErrorProvider errorProvider,
    this.onIsLoadingLoadDataResultWidget,
    this.onSuccessLoadDataResultWidget,
    this.onFailedLoadDataResultWidget,
    this.onNoLoadingLoadDataResultWidget,
    DefaultLoadDataResultWidget? defaultLoadDataResultWidget
  }) : _defaultLoadDataResultWidget = defaultLoadDataResultWidget, super(
    key: key,
    loadDataResult: loadDataResult,
    errorProvider: errorProvider,
  );

  @override
  Widget build(BuildContext context) {
    if (loadDataResult is IsLoadingLoadDataResult) {
      Widget defaultLoadingWidget = defaultLoadDataResultWidget.isLoadingLoadDataResultWidget(context, loadDataResult as IsLoadingLoadDataResult);
      if (onIsLoadingLoadDataResultWidget != null) {
        return onIsLoadingLoadDataResultWidget!(defaultLoadingWidget);
      } else {
        return defaultLoadingWidget;
      }
    } else if (loadDataResult is SuccessLoadDataResult) {
      Widget defaultSuccessWidget = defaultLoadDataResultWidget.successLoadDataResultWidget(context, loadDataResult as SuccessLoadDataResult);
      if (onSuccessLoadDataResultWidget != null) {
        return onSuccessLoadDataResultWidget!((loadDataResult as SuccessLoadDataResult).value);
      } else {
        return defaultSuccessWidget;
      }
    } else if (loadDataResult is FailedLoadDataResult) {
      FailedLoadDataResult failedLoadDataResult = loadDataResult as FailedLoadDataResult;
      dynamic e = failedLoadDataResult.e;
      Widget defaultErrorPromptIndicator = defaultLoadDataResultWidget.failedLoadDataResultWidget(context, failedLoadDataResult, errorProvider);
      if (onFailedLoadDataResultWidget != null) {
        return onFailedLoadDataResultWidget!(errorProvider, e, defaultErrorPromptIndicator);
      } else {
        return defaultErrorPromptIndicator;
      }
    } else {
      Widget defaultNoLoadingWidget = defaultLoadDataResultWidget.noLoadDataResultWidget(context, loadDataResult as NoLoadDataResult);
      if (onNoLoadingLoadDataResultWidget != null) {
        return onNoLoadingLoadDataResultWidget!();
      } else {
        return defaultNoLoadingWidget;
      }
    }
  }
}