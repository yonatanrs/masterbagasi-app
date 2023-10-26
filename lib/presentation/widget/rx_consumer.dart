import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../misc/typedef.dart';

class RxConsumer<T> extends StatelessWidget {
  final Rx<T> rxValue;
  final WidgetBuilderWithRx<T> onConsumeValue;

  const RxConsumer({
    Key? key,
    required this.rxValue,
    required this.onConsumeValue
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => onConsumeValue(context, rxValue.value));
  }
}