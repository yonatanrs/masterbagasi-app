import 'package:flutter/material.dart';

import '../../../misc/errorprovider/error_provider.dart';
import '../../../misc/load_data_result.dart';
import '../../../misc/defaultloaddataresultwidget/default_load_data_result_widget.dart';

abstract class BaseLoadDataResultImplementer<T> extends StatelessWidget {
  final LoadDataResult<T> loadDataResult;
  final ErrorProvider errorProvider;

  @protected
  DefaultLoadDataResultWidget get defaultLoadDataResultWidget;

  const BaseLoadDataResultImplementer({
    Key? key,
    required this.loadDataResult,
    required this.errorProvider,
  }): super(key: key);
}