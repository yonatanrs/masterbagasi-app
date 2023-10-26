import 'package:get/get.dart';
import 'package:masterbagasi/misc/ext/string_ext.dart';

import '../../misc/error/validation_error.dart';
import '../../misc/manager/controller_manager.dart';
import '../../misc/typedef.dart';
import '../../misc/validation/validation_result.dart';
import '../../misc/validation/validator/validator.dart';
import '../../misc/validation/validatorgroup/add_cart_note_validator_group.dart';
import 'modal_dialog_controller.dart';

typedef _OnGetAddCartNoteInput = String Function();
typedef _OnAddCartNoteBack = void Function();
typedef _OnAddCartNoteRequestProcessSuccessCallback = Future<void> Function(String);

class AddCartNoteModalDialogController extends ModalDialogController {
  late Rx<Validator> noteValidatorRx;
  late final AddCartNoteValidatorGroup addCartNoteValidatorGroup;

  AddCartNoteModalDialogDelegate? _addCartNoteModalDialogDelegate;

  AddCartNoteModalDialogController(
    ControllerManager? controllerManager,
  ) : super(controllerManager) {
    addCartNoteValidatorGroup = AddCartNoteValidatorGroup(
      noteValidator: Validator(
        onValidate: () => !_addCartNoteModalDialogDelegate!.onGetNotesInput().isEmptyString ? SuccessValidationResult() : FailedValidationResult(e: ValidationError(message: "${"Cart note is required".tr}."))
      )
    );
    noteValidatorRx = addCartNoteValidatorGroup.noteValidator.obs;
  }

  AddCartNoteModalDialogController setAddCartNoteModalDialogDelegate(AddCartNoteModalDialogDelegate addCartNoteModalDialogDelegate) {
    _addCartNoteModalDialogDelegate = addCartNoteModalDialogDelegate;
    return this;
  }

  void addCartNote() async {
    if (_addCartNoteModalDialogDelegate != null) {
      _addCartNoteModalDialogDelegate!.onUnfocusAllWidget();
      if (addCartNoteValidatorGroup.validate()) {
        _addCartNoteModalDialogDelegate!.onAddCartNoteRequestProcessSuccessCallback(
          _addCartNoteModalDialogDelegate!.onGetNotesInput()
        );
      }
    }
  }
}

class AddCartNoteModalDialogDelegate {
  OnUnfocusAllWidget onUnfocusAllWidget;
  _OnGetAddCartNoteInput onGetNotesInput;
  _OnAddCartNoteBack onAddCartNoteBack;
  _OnAddCartNoteRequestProcessSuccessCallback onAddCartNoteRequestProcessSuccessCallback;

  AddCartNoteModalDialogDelegate({
    required this.onUnfocusAllWidget,
    required this.onGetNotesInput,
    required this.onAddCartNoteBack,
    required this.onAddCartNoteRequestProcessSuccessCallback
  });
}