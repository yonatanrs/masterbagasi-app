import 'package:flutter/material.dart';

import '../errorprovider/error_provider.dart';
import '../load_data_result.dart';
import 'main_default_load_data_result_widget.dart';

abstract class DefaultLoadDataResultWidget {
  Widget noLoadDataResultWidget(BuildContext context, NoLoadDataResult noLoadDataResult);
  Widget isLoadingLoadDataResultWidget(BuildContext context, IsLoadingLoadDataResult isLoadingLoadDataResult);
  Widget successLoadDataResultWidget(BuildContext context, SuccessLoadDataResult successLoadDataResult);
  Widget failedLoadDataResultWidget(BuildContext context, FailedLoadDataResult failedLoadDataResult, ErrorProvider errorProvider, {FailedLoadDataResultConfig? failedLoadDataResultConfig});
  Widget failedLoadDataResultWithButtonWidget(BuildContext context, FailedLoadDataResult failedLoadDataResult, ErrorProvider errorProvider, {FailedLoadDataResultConfig? failedLoadDataResultConfig});
}