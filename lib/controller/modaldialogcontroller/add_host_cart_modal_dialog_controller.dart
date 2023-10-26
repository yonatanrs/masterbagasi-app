import 'package:get/get.dart';
import 'package:masterbagasi/misc/ext/load_data_result_ext.dart';
import 'package:masterbagasi/misc/ext/string_ext.dart';

import '../../domain/entity/cart/add_host_cart_parameter.dart';
import '../../domain/entity/cart/add_host_cart_response.dart';
import '../../domain/usecase/add_host_cart_use_case.dart';
import '../../misc/error/validation_error.dart';
import '../../misc/load_data_result.dart';
import '../../misc/manager/controller_manager.dart';
import '../../misc/typedef.dart';
import '../../misc/validation/validation_result.dart';
import '../../misc/validation/validator/validator.dart';
import '../../misc/validation/validatorgroup/add_host_cart_validator_group.dart';
import 'modal_dialog_controller.dart';

typedef _OnGetAddHostCartInput = String Function();
typedef _OnShowAddHostCartRequestProcessLoadingCallback = Future<void> Function();
typedef _OnAddHostCartRequestProcessSuccessCallback = Future<void> Function();
typedef _OnShowAddHostCartRequestProcessFailedCallback = Future<void> Function(dynamic e);
typedef _OnAddHostCartBack = void Function();

class AddHostCartModalDialogController extends ModalDialogController {
  final AddHostCartUseCase addHostCartUseCase;

  late Rx<Validator> hostCartIdValidatorRx;
  late Rx<Validator> hostCartPasswordValidatorRx;
  late final AddHostCartValidatorGroup addHostCartValidatorGroup;

  AddHostCartModalDialogDelegate? _addHostCartModalDialogDelegate;

  AddHostCartModalDialogController(
    ControllerManager? controllerManager,
    this.addHostCartUseCase
  ) : super(controllerManager) {
    addHostCartValidatorGroup = AddHostCartValidatorGroup(
      hostCartIdValidator: Validator(
        onValidate: () => !_addHostCartModalDialogDelegate!.onGetHostCartIdInput().isEmptyString ? SuccessValidationResult() : FailedValidationResult(e: ValidationError(message: "${"Host cart id is required".tr}."))
      ),
      hostCartPasswordValidator: Validator(
        onValidate: () => !_addHostCartModalDialogDelegate!.onGetHostCartPasswordInput().isEmptyString ? SuccessValidationResult() : FailedValidationResult(e: ValidationError(message: "${"Host cart password is required".tr}."))
      ),
    );
    hostCartIdValidatorRx = addHostCartValidatorGroup.hostCartIdValidator.obs;
    hostCartPasswordValidatorRx = addHostCartValidatorGroup.hostCartPasswordValidator.obs;
  }

  AddHostCartModalDialogController setAddHostCartModalDialogDelegate(AddHostCartModalDialogDelegate addHostCartModalDialogDelegate) {
    _addHostCartModalDialogDelegate = addHostCartModalDialogDelegate;
    return this;
  }

  void createHostCart() async {
    if (_addHostCartModalDialogDelegate != null) {
      _addHostCartModalDialogDelegate!.onUnfocusAllWidget();
      if (addHostCartValidatorGroup.validate()) {
        _addHostCartModalDialogDelegate!.onShowAddHostCartRequestProcessLoadingCallback();
        LoadDataResult<AddHostCartResponse> addHostCartResponseLoadDataResult = await addHostCartUseCase.execute(
          AddHostCartParameter(
            hostCartId: _addHostCartModalDialogDelegate!.onGetHostCartIdInput(),
            hostCartPassword: _addHostCartModalDialogDelegate!.onGetHostCartPasswordInput(),
          )
        ).future(
          parameter: apiRequestManager.addRequestToCancellationPart('add-host-cart').value
        );
        _addHostCartModalDialogDelegate!.onAddHostCartBack();
        if (addHostCartResponseLoadDataResult.isSuccess) {
          _addHostCartModalDialogDelegate!.onAddHostCartRequestProcessSuccessCallback();
        } else {
          _addHostCartModalDialogDelegate!.onShowAddHostCartRequestProcessFailedCallback(addHostCartResponseLoadDataResult.resultIfFailed);
        }
      }
    }
  }
}

class AddHostCartModalDialogDelegate {
  OnUnfocusAllWidget onUnfocusAllWidget;
  _OnGetAddHostCartInput onGetHostCartIdInput;
  _OnGetAddHostCartInput onGetHostCartPasswordInput;
  _OnShowAddHostCartRequestProcessLoadingCallback onShowAddHostCartRequestProcessLoadingCallback;
  _OnAddHostCartRequestProcessSuccessCallback onAddHostCartRequestProcessSuccessCallback;
  _OnShowAddHostCartRequestProcessFailedCallback onShowAddHostCartRequestProcessFailedCallback;
  _OnAddHostCartBack onAddHostCartBack;

  AddHostCartModalDialogDelegate({
    required this.onUnfocusAllWidget,
    required this.onGetHostCartIdInput,
    required this.onGetHostCartPasswordInput,
    required this.onShowAddHostCartRequestProcessLoadingCallback,
    required this.onAddHostCartRequestProcessSuccessCallback,
    required this.onShowAddHostCartRequestProcessFailedCallback,
    required this.onAddHostCartBack
  });
}