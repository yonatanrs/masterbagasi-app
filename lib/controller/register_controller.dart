import 'package:get/get.dart';
import 'package:masterbagasi/misc/ext/load_data_result_ext.dart';
import 'package:masterbagasi/misc/ext/string_ext.dart';

import '../domain/entity/register/register_parameter.dart';
import '../domain/entity/register/register_response.dart';
import '../domain/entity/register/register_with_google_parameter.dart';
import '../domain/entity/register/register_with_google_response.dart';
import '../domain/usecase/register_use_case.dart';
import '../domain/usecase/register_with_google_use_case.dart';
import '../misc/error/validation_error.dart';
import '../misc/load_data_result.dart';
import '../misc/login_helper.dart';
import '../misc/manager/controller_manager.dart';
import '../misc/typedef.dart';
import '../misc/validation/validation_result.dart';
import '../misc/validation/validator/compoundvalidator/password_compound_validator.dart';
import '../misc/validation/validator/email_validator.dart';
import '../misc/validation/validator/validator.dart';
import '../misc/validation/validatorgroup/register_validator_group.dart';
import 'base_getx_controller.dart';

typedef _OnGetRegisterInput = String Function();
typedef _OnRegisterBack = void Function();
typedef _OnShowRegisterRequestProcessLoadingCallback = Future<void> Function();
typedef _OnRegisterRequestProcessSuccessCallback = Future<void> Function();
typedef _OnShowRegisterRequestProcessFailedCallback = Future<void> Function(dynamic e);
typedef _OnRegisterWithGoogle = Future<String?> Function();

class RegisterController extends BaseGetxController {
  final RegisterUseCase registerUseCase;
  final RegisterWithGoogleUseCase registerWithGoogleUseCase;

  late Rx<Validator> emailValidatorRx;
  late Rx<Validator> nameValidatorRx;
  late Rx<PasswordCompoundValidator> passwordCompoundValidatorRx;
  late final RegisterValidatorGroup registerValidatorGroup;

  RegisterDelegate? _registerDelegate;

  RegisterController(
    ControllerManager? controllerManager,
    this.registerUseCase,
    this.registerWithGoogleUseCase
  ) : super(controllerManager) {
    registerValidatorGroup = RegisterValidatorGroup(
      emailValidator: EmailValidator(
        email: () => _registerDelegate!.onGetEmailRegisterInput()
      ),
      nameValidator: Validator(
        onValidate: () => !_registerDelegate!.onGetNameRegisterInput().isEmptyString ? SuccessValidationResult() : FailedValidationResult(e: ValidationError(message: "${"Name is required".tr}."))
      ),
      passwordCompoundValidator: PasswordCompoundValidator(
        passwordValidator: Validator(
          onValidate: () => !_registerDelegate!.onGetPasswordRegisterInput().isEmptyString ? SuccessValidationResult() : FailedValidationResult(e: ValidationError(message: "${"Password is required".tr}."))
        ),
        passwordConfirmationValidator: Validator(
          onValidate: () {
            String password = _registerDelegate!.onGetPasswordRegisterInput();
            String passwordConfirmation = _registerDelegate!.onGetPasswordConfirmationRegisterInput();
            if (password != passwordConfirmation) {
              return FailedValidationResult(e: ValidationError(message: "${"Password must be same with password confirmation".tr}."));
            } else {
              return SuccessValidationResult();
            }
          }
        )
      )
    );
    emailValidatorRx = registerValidatorGroup.emailValidator.obs;
    nameValidatorRx = registerValidatorGroup.nameValidator.obs;
    passwordCompoundValidatorRx = registerValidatorGroup.passwordCompoundValidator.obs;
  }

  RegisterController setRegisterDelegate(RegisterDelegate registerDelegate) {
    _registerDelegate = registerDelegate;
    return this;
  }

  void register() async {
    if (_registerDelegate != null) {
      _registerDelegate!.onUnfocusAllWidget();
      if (registerValidatorGroup.validate()) {
        _registerDelegate!.onShowRegisterRequestProcessLoadingCallback();
        LoadDataResult<RegisterResponse> registerLoadDataResult = await registerUseCase.execute(
          RegisterParameter(
            email: _registerDelegate!.onGetEmailRegisterInput(),
            name: _registerDelegate!.onGetNameRegisterInput(),
            password: _registerDelegate!.onGetPasswordRegisterInput(),
            passwordConfirmation: _registerDelegate!.onGetPasswordConfirmationRegisterInput()
          )
        ).future(
          parameter: apiRequestManager.addRequestToCancellationPart('register').value
        );
        Get.back();
        if (registerLoadDataResult.isSuccess) {
          await LoginHelper.saveToken(registerLoadDataResult.resultIfSuccess!.token).future();
          _registerDelegate!.onRegisterRequestProcessSuccessCallback();
        } else {
          _registerDelegate!.onShowRegisterRequestProcessFailedCallback(registerLoadDataResult.resultIfFailed);
        }
      }
    }
  }

  void registerWithGoogle() async {
    if (_registerDelegate != null) {
      _registerDelegate!.onUnfocusAllWidget();
      String? idToken = await _registerDelegate!.onRegisterWithGoogle();
      if (idToken.isNotEmptyString) {
        _registerDelegate!.onShowRegisterRequestProcessLoadingCallback();
        LoadDataResult<RegisterWithGoogleResponse> registerWithGoogleLoadDataResult = await registerWithGoogleUseCase.execute(
          RegisterWithGoogleParameter(
            idToken: idToken!
          )
        ).future(
          parameter: apiRequestManager.addRequestToCancellationPart('register-with-google').value
        );
        Get.back();
        if (registerWithGoogleLoadDataResult.isSuccess) {
          await LoginHelper.saveToken(registerWithGoogleLoadDataResult.resultIfSuccess!.token).future();
          _registerDelegate!.onRegisterRequestProcessSuccessCallback();
        } else {
          _registerDelegate!.onShowRegisterRequestProcessFailedCallback(registerWithGoogleLoadDataResult.resultIfFailed);
        }
      }
    }
  }
}

class RegisterDelegate {
  OnUnfocusAllWidget onUnfocusAllWidget;
  _OnRegisterBack onRegisterBack;
  _OnGetRegisterInput onGetEmailRegisterInput;
  _OnGetRegisterInput onGetNameRegisterInput;
  _OnGetRegisterInput onGetPasswordRegisterInput;
  _OnGetRegisterInput onGetPasswordConfirmationRegisterInput;
  _OnShowRegisterRequestProcessLoadingCallback onShowRegisterRequestProcessLoadingCallback;
  _OnRegisterRequestProcessSuccessCallback onRegisterRequestProcessSuccessCallback;
  _OnShowRegisterRequestProcessFailedCallback onShowRegisterRequestProcessFailedCallback;
  _OnRegisterWithGoogle onRegisterWithGoogle;

  RegisterDelegate({
    required this.onUnfocusAllWidget,
    required this.onRegisterBack,
    required this.onGetEmailRegisterInput,
    required this.onGetNameRegisterInput,
    required this.onGetPasswordRegisterInput,
    required this.onGetPasswordConfirmationRegisterInput,
    required this.onShowRegisterRequestProcessLoadingCallback,
    required this.onRegisterRequestProcessSuccessCallback,
    required this.onShowRegisterRequestProcessFailedCallback,
    required this.onRegisterWithGoogle
  });
}