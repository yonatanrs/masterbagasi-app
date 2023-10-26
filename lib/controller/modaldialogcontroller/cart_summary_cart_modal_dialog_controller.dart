import 'package:get/get.dart';
import 'package:masterbagasi/misc/ext/rx_ext.dart';

import '../../domain/entity/cart/cart_summary.dart';
import '../../domain/entity/cart/cart_summary_parameter.dart';
import '../../domain/usecase/get_cart_summary_use_case.dart';
import '../../misc/load_data_result.dart';
import '../../misc/manager/controller_manager.dart';
import 'modal_dialog_controller.dart';

class CartSummaryCartModalDialogController extends ModalDialogController {
  final GetCartSummaryUseCase getCartSummaryUseCase;

  LoadDataResult<CartSummary> _cartSummaryLoadDataResult = NoLoadDataResult<CartSummary>();
  late Rx<LoadDataResultWrapper<CartSummary>> cartSummaryLoadDataResultWrapperRx;
  bool _hasInitCartSummary = false;

  CartSummaryCartModalDialogController(
    ControllerManager? controllerManager,
    this.getCartSummaryUseCase
  ) : super(controllerManager) {
    cartSummaryLoadDataResultWrapperRx = LoadDataResultWrapper<CartSummary>(_cartSummaryLoadDataResult).obs;
  }
}