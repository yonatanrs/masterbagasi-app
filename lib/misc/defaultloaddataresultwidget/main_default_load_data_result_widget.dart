import 'package:flutter/material.dart';

import '../../presentation/widget/modified_loading_indicator.dart';
import '../../presentation/widget/prompt_indicator.dart';
import '../errorprovider/error_provider.dart';
import '../load_data_result.dart';
import '../widget_helper.dart';
import 'default_load_data_result_widget.dart';

class MainDefaultLoadDataResultWidget extends DefaultLoadDataResultWidget {
  @override
  Widget noLoadDataResultWidget(BuildContext context, NoLoadDataResult noLoadDataResult) {
    return Container();
  }

  @override
  Widget isLoadingLoadDataResultWidget(BuildContext context, IsLoadingLoadDataResult isLoadingLoadDataResult) {
    return const Center(child: ModifiedLoadingIndicator());
  }

  @override
  Widget successLoadDataResultWidget(BuildContext context, SuccessLoadDataResult successLoadDataResult) {
    return Container();
  }

  @override
  Widget failedLoadDataResultWidget(BuildContext context, FailedLoadDataResult failedLoadDataResult, ErrorProvider errorProvider, {FailedLoadDataResultConfig? failedLoadDataResultConfig}) {
    return WidgetHelper.buildFailedPromptIndicatorFromErrorProvider(
      context: context,
      errorProvider: errorProvider,
      e: failedLoadDataResult.e,
      promptIndicatorType: failedLoadDataResultConfig?.promptIndicatorType ?? PromptIndicatorType.vertical
    );
  }

  @override
  Widget failedLoadDataResultWithButtonWidget(BuildContext context, FailedLoadDataResult failedLoadDataResult, ErrorProvider errorProvider, {FailedLoadDataResultConfig? failedLoadDataResultConfig}) {
    return WidgetHelper.buildFailedPromptIndicatorFromErrorProvider(
      context: context,
      errorProvider: errorProvider,
      e: failedLoadDataResult.e,
      onPressed: failedLoadDataResultConfig?.onPressed,
      buttonText: failedLoadDataResultConfig?.buttonText,
      promptIndicatorType: failedLoadDataResultConfig?.promptIndicatorType ?? PromptIndicatorType.vertical
    );
  }
}

class FailedLoadDataResultConfig {
  void Function()? onPressed;
  String? buttonText;
  PromptIndicatorType promptIndicatorType;

  FailedLoadDataResultConfig({
    this.onPressed,
    this.buttonText,
    this.promptIndicatorType = PromptIndicatorType.vertical
  });
}