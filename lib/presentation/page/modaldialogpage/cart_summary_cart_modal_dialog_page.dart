import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masterbagasi/misc/ext/number_ext.dart';
import 'package:sizer/sizer.dart';

import '../../../controller/modaldialogcontroller/cart_summary_cart_modal_dialog_controller.dart';
import '../../../domain/entity/cart/cart_summary.dart';
import '../../../domain/entity/summaryvalue/summary_value.dart';
import '../../../domain/usecase/get_cart_summary_use_case.dart';
import '../../../misc/injector.dart';
import '../../../misc/load_data_result.dart';
import '../../widget/horizontal_justified_title_and_description.dart';
import '../../widget/rx_consumer.dart';
import '../../widget/summary_widget.dart';
import 'modal_dialog_page.dart';

class CartSummaryCartModalDialogPage extends ModalDialogPage<CartSummaryCartModalDialogController> {
  CartSummaryCartModalDialogController get cartSummaryCartModalDialogController => modalDialogController.controller;

  final CartSummary cartSummary;

  CartSummaryCartModalDialogPage({
    Key? key,
    required this.cartSummary
  }) : super(key: key);

  @override
  CartSummaryCartModalDialogController onCreateModalDialogController() {
    return CartSummaryCartModalDialogController(
      controllerManager,
      Injector.locator<GetCartSummaryUseCase>()
    );
  }

  @override
  Widget buildPage(BuildContext context) {
    return _StatefulCartSummaryControllerMediatorWidget(
      cartSummaryCartModalDialogController: cartSummaryCartModalDialogController,
      cartSummary: cartSummary
    );
  }
}

class _StatefulCartSummaryControllerMediatorWidget extends StatefulWidget {
  final CartSummaryCartModalDialogController cartSummaryCartModalDialogController;
  final CartSummary cartSummary;

  const _StatefulCartSummaryControllerMediatorWidget({
    required this.cartSummaryCartModalDialogController,
    required this.cartSummary
  });

  @override
  State<_StatefulCartSummaryControllerMediatorWidget> createState() => _StatefulCartSummaryControllerMediatorWidgetState();
}

class _StatefulCartSummaryControllerMediatorWidgetState extends State<_StatefulCartSummaryControllerMediatorWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(4.w),
      child: RxConsumer<LoadDataResultWrapper<CartSummary>>(
        rxValue: widget.cartSummaryCartModalDialogController.cartSummaryLoadDataResultWrapperRx,
        onConsumeValue: (context, cartSummaryLoadDataResultWrapper) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Builder(
              builder: (context) {
                CartSummary cartSummary = widget.cartSummary;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Cart Summary".tr,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17
                      ),
                    ),
                    const SizedBox(height: 10),
                    SummaryWidget(baseSummary: cartSummary)
                  ]
                );
              }
            )
          ]
        )
      )
    );
  }
}