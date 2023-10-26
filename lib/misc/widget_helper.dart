import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../presentation/widget/loaddataresultimplementer/load_data_result_implementer_directly.dart';
import '../presentation/widget/prompt_indicator.dart';
import 'constant.dart';
import 'constrained_app_bar_return_value.dart';
import 'defaultloaddataresultwidget/main_default_load_data_result_widget.dart';
import 'error/token_empty_error.dart';
import 'errorprovider/error_provider.dart';
import 'injector.dart';
import 'load_data_result.dart';
import 'login_helper.dart';
import 'page_restoration_helper.dart';

class _WidgetHelperImpl {
  Widget buildPromptIndicator({
    required BuildContext context,
    Image? image,
    String? promptTitleText,
    String? promptText,
    String? buttonText,
    VoidCallback? onPressed,
    required PromptIndicatorType promptIndicatorType
  }) {
    return PromptIndicator(
      image: image,
      promptTitleText: promptTitleText,
      promptText: promptText,
      buttonText: buttonText ?? "OK",
      onPressed: onPressed,
      promptIndicatorType: promptIndicatorType
    );
  }

  Widget buildSuccessPromptIndicator({
    required BuildContext context,
    Image? image,
    String? promptTitleText = "Success",
    String? promptText = "This process has been success...",
    String? buttonText,
    VoidCallback? onPressed,
    PromptIndicatorType promptIndicatorType = PromptIndicatorType.vertical
  }) {
    return buildPromptIndicator(
      context: context,
      image: image ?? Image.asset(Constant.imageSuccess),
      promptTitleText: promptTitleText,
      promptText: promptText,
      buttonText: buttonText,
      onPressed: onPressed,
      promptIndicatorType: promptIndicatorType
    );
  }

  Widget buildFailedPromptIndicator({
    required BuildContext context,
    Image? image,
    String? promptTitleText,
    String? promptText,
    String? buttonText,
    VoidCallback? onPressed,
    PromptIndicatorType promptIndicatorType = PromptIndicatorType.vertical
  }) {
    return buildPromptIndicator(
      context: context,
      image: image ?? Image.asset(Constant.imageFailed),
      promptTitleText: promptTitleText,
      promptText: promptText,
      buttonText: buttonText,
      onPressed: onPressed,
      promptIndicatorType: promptIndicatorType
    );
  }

  Widget buildFailedPromptIndicatorFromErrorProvider({
    required BuildContext context,
    required ErrorProvider errorProvider,
    required dynamic e,
    String? buttonText,
    VoidCallback? onPressed,
    PromptIndicatorType promptIndicatorType = PromptIndicatorType.vertical
  }) {
    ErrorProviderResult? errorProviderResult = errorProvider.onGetErrorProviderResult(e);
    return buildPromptIndicator(
      context: context,
      image: errorProviderResult != null ? Image.asset(errorProviderResult.imageAssetUrl.isEmpty ? Constant.imageFailed : errorProviderResult.imageAssetUrl) : null,
      promptTitleText: errorProviderResult?.title,
      promptText: errorProviderResult?.message,
      buttonText: buttonText,
      onPressed: onPressed,
      promptIndicatorType: promptIndicatorType
    );
  }

  double getAppBarAndStatusHeight(AppBar appBar, BuildContext context) {
    return appBar.preferredSize.height + MediaQuery.of(context).viewPadding.top;
  }

  ConstrainedAppBarReturnValue constrainedAppBar({
    required AppBar appBar,
    Widget? appBarWidget,
    required BuildContext context
  }) {
    double appBarAndStatusHeight = WidgetHelper.getAppBarAndStatusHeight(appBar, context);
    return ConstrainedAppBarReturnValue(
      appBar: SizedBox(
        height: appBarAndStatusHeight,
        child: appBarWidget ?? appBar
      ),
      appBarAndStatusHeight: appBarAndStatusHeight,
    );
  }

  Widget checkingLogin(BuildContext context, Widget Function() resultIfHasBeenLogin, ErrorProvider errorProvider) {
    if (LoginHelper.getTokenWithBearer().result.isNotEmpty) {
      return resultIfHasBeenLogin();
    }
    return Center(
      child: LoadDataResultImplementerDirectlyWithDefault<String>(
        errorProvider: errorProvider,
        loadDataResult: FailedLoadDataResult.throwException(() => throw TokenEmptyError())!,
        onImplementLoadDataResultDirectlyWithDefault: (loadDataResult, errorProvider, defaultLoadDataResultWidget) {
          return defaultLoadDataResultWidget.failedLoadDataResultWithButtonWidget(
            context,
            loadDataResult as FailedLoadDataResult<String>,
            errorProvider,
            failedLoadDataResultConfig: FailedLoadDataResultConfig(
              onPressed: () => PageRestorationHelper.toLoginPage(context, Constant.restorableRouteFuturePush),
              buttonText: "Login".tr
            )
          );
        }
      ),
    );
  }
}

// ignore: non_constant_identifier_names
var WidgetHelper = _WidgetHelperImpl();