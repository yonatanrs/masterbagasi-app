import 'package:get/get.dart';
import 'package:masterbagasi/misc/ext/load_data_result_ext.dart';
import 'package:masterbagasi/misc/ext/string_ext.dart';
import 'package:masterbagasi/misc/manager/controller_manager.dart';
import 'package:masterbagasi/misc/validation/validation_result.dart';

import '../domain/entity/login/login_parameter.dart';
import '../domain/entity/login/login_response.dart';
import '../domain/entity/login/login_with_google_parameter.dart';
import '../domain/entity/login/login_with_google_response.dart';
import '../domain/usecase/login_use_case.dart';
import '../domain/usecase/login_with_google_use_case.dart';
import '../misc/error/validation_error.dart';
import '../misc/load_data_result.dart';
import '../misc/login_helper.dart';
import '../misc/typedef.dart';
import '../misc/validation/validator/email_validator.dart';
import '../misc/validation/validator/validator.dart';
import '../misc/validation/validatorgroup/login_validator_group.dart';
import 'base_getx_controller.dart';

typedef _OnGetLoginInput = String Function();
typedef _OnLoginBack = void Function();
typedef _OnShowLoginRequestProcessLoadingCallback = Future<void> Function();
typedef _OnLoginRequestProcessSuccessCallback = Future<void> Function();
typedef _OnShowLoginRequestProcessFailedCallback = Future<void> Function(dynamic e);
typedef _OnLoginWithGoogle = Future<String?> Function();

class LoginController extends BaseGetxController {
  final LoginUseCase loginUseCase;
  final LoginWithGoogleUseCase loginWithGoogleUseCase;

  late Rx<Validator> emailValidatorRx;
  late Rx<Validator> passwordValidatorRx;
  late final LoginValidatorGroup loginValidatorGroup;

  LoginDelegate? _loginDelegate;

  LoginController(
    ControllerManager? controllerManager,
    this.loginUseCase,
    this.loginWithGoogleUseCase
  ) : super(controllerManager) {
    loginValidatorGroup = LoginValidatorGroup(
      emailValidator: EmailValidator(
        email: () => _loginDelegate!.onGetEmailLoginInput()
      ),
      passwordValidator: Validator(
        onValidate: () => !_loginDelegate!.onGetEmailLoginInput().isEmptyString ? SuccessValidationResult() : FailedValidationResult(e: ValidationError(message: "${"Password is required".tr}."))
      )
    );
    emailValidatorRx = loginValidatorGroup.emailValidator.obs;
    passwordValidatorRx = loginValidatorGroup.passwordValidator.obs;
  }

  LoginController setLoginDelegate(LoginDelegate loginDelegate) {
    _loginDelegate = loginDelegate;
    return this;
  }

  void login() async {
    if (_loginDelegate != null) {
      _loginDelegate!.onUnfocusAllWidget();
      if (loginValidatorGroup.validate()) {
        _loginDelegate!.onShowLoginRequestProcessLoadingCallback();
        LoadDataResult<LoginResponse> loginLoadDataResult = await loginUseCase.execute(
          LoginParameter(
            email: _loginDelegate!.onGetEmailLoginInput(),
            password: _loginDelegate!.onGetPasswordLoginInput(),
          )
        ).future(
          parameter: apiRequestManager.addRequestToCancellationPart('login').value
        );
        Get.back();
        if (loginLoadDataResult.isSuccess) {
          await LoginHelper.saveToken(loginLoadDataResult.resultIfSuccess!.token).future();
          _loginDelegate!.onLoginRequestProcessSuccessCallback();
        } else {
          _loginDelegate!.onShowLoginRequestProcessFailedCallback(loginLoadDataResult.resultIfFailed);
        }
      }
    }
  }

  void loginWithGoogle() async {
    if (_loginDelegate != null) {
      _loginDelegate!.onUnfocusAllWidget();
      String? idToken = await _loginDelegate!.onLoginWithGoogle();
      if (idToken.isNotEmptyString) {
        _loginDelegate!.onShowLoginRequestProcessLoadingCallback();
        LoadDataResult<LoginWithGoogleResponse> loginWithGoogleLoadDataResult = await loginWithGoogleUseCase.execute(
          LoginWithGoogleParameter(
            idToken: idToken!
          )
        ).future(
          parameter: apiRequestManager.addRequestToCancellationPart('login-with-google').value
        );
        Get.back();
        if (loginWithGoogleLoadDataResult.isSuccess) {
          await LoginHelper.saveToken(loginWithGoogleLoadDataResult.resultIfSuccess!.token).future();
          _loginDelegate!.onLoginRequestProcessSuccessCallback();
        } else {
          _loginDelegate!.onShowLoginRequestProcessFailedCallback(loginWithGoogleLoadDataResult.resultIfFailed);
        }
      }
    }
  }
}

class LoginDelegate {
  OnUnfocusAllWidget onUnfocusAllWidget;
  _OnGetLoginInput onGetEmailLoginInput;
  _OnLoginBack onLoginBack;
  _OnGetLoginInput onGetPasswordLoginInput;
  _OnShowLoginRequestProcessLoadingCallback onShowLoginRequestProcessLoadingCallback;
  _OnLoginRequestProcessSuccessCallback onLoginRequestProcessSuccessCallback;
  _OnShowLoginRequestProcessFailedCallback onShowLoginRequestProcessFailedCallback;
  _OnLoginWithGoogle onLoginWithGoogle;

  LoginDelegate({
    required this.onUnfocusAllWidget,
    required this.onGetEmailLoginInput,
    required this.onLoginBack,
    required this.onGetPasswordLoginInput,
    required this.onShowLoginRequestProcessLoadingCallback,
    required this.onLoginRequestProcessSuccessCallback,
    required this.onShowLoginRequestProcessFailedCallback,
    required this.onLoginWithGoogle,
  });
}