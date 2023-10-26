import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:masterbagasi/misc/ext/validation_result_ext.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../controller/login_controller.dart';
import '../../controller/register_controller.dart';
import '../../domain/usecase/register_use_case.dart';
import '../../domain/usecase/register_with_google_use_case.dart';
import '../../misc/constant.dart';
import '../../misc/dialog_helper.dart';
import '../../misc/errorprovider/error_provider.dart';
import '../../misc/getextended/get_extended.dart';
import '../../misc/getextended/get_restorable_route_future.dart';
import '../../misc/injector.dart';
import '../../misc/inputdecoration/default_input_decoration.dart';
import '../../misc/main_route_observer.dart';
import '../../misc/manager/controller_manager.dart';
import '../../misc/navigation_helper.dart';
import '../../misc/page_restoration_helper.dart';
import '../../misc/recognizer/sign_up_recognizer.dart';
import '../../misc/validation/validator/compoundvalidator/password_compound_validator.dart';
import '../../misc/validation/validator/validator.dart';
import '../notifier/login_notifier.dart';
import '../widget/button/custombutton/sized_outline_gradient_button.dart';
import '../widget/field.dart';
import '../widget/modified_text_field.dart';
import '../widget/modifiedappbar/modified_app_bar.dart';
import '../widget/password_obscurer.dart';
import '../widget/rx_consumer.dart';
import 'getx_page.dart';

class RegisterPage extends RestorableGetxPage<_RegisterPageRestoration> {
  late final ControllerMember<RegisterController> _registerController = ControllerMember<RegisterController>().addToControllerManager(controllerManager);

  RegisterPage({Key? key}) : super(key: key, pageRestorationId: () => "register-page");

  @override
  void onSetController() {
    _registerController.controller = GetExtended.put<RegisterController>(
      RegisterController(
        controllerManager,
        Injector.locator<RegisterUseCase>(),
        Injector.locator<RegisterWithGoogleUseCase>()
      ), tag: pageName
    );
  }

  @override
  _RegisterPageRestoration createPageRestoration() => _RegisterPageRestoration();

  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      body: _StatefulRegisterControllerMediatorWidget(
        registerController: _registerController.controller,
      ),
    );
  }
}

class _RegisterPageRestoration extends MixableGetxPageRestoration {
  @override
  // ignore: unnecessary_overrides
  void initState() {
    super.initState();
  }

  @override
  // ignore: unnecessary_overrides
  void restoreState(Restorator restorator, RestorationBucket? oldBucket, bool initialRestore) {
    super.restoreState(restorator, oldBucket, initialRestore);
  }

  @override
  // ignore: unnecessary_overrides
  void dispose() {
    super.dispose();
  }
}

class RegisterPageGetPageBuilderAssistant extends GetPageBuilderAssistant {
  @override
  GetPageBuilder get pageBuilder => (() => RegisterPage());

  @override
  GetPageBuilder get pageWithOuterGetxBuilder => (() => GetxPageBuilder.buildRestorableGetxPage(RegisterPage()));
}

mixin RegisterPageRestorationMixin on MixableGetxPageRestoration {
  late RegisterPageRestorableRouteFuture registerPageRestorableRouteFuture;

  @override
  void initState() {
    super.initState();
    registerPageRestorableRouteFuture = RegisterPageRestorableRouteFuture(restorationId: restorationIdWithPageName('register-route'));
  }

  @override
  void restoreState(Restorator restorator, RestorationBucket? oldBucket, bool initialRestore) {
    super.restoreState(restorator, oldBucket, initialRestore);
    registerPageRestorableRouteFuture.restoreState(restorator, oldBucket, initialRestore);
  }

  @override
  void dispose() {
    super.dispose();
    registerPageRestorableRouteFuture.dispose();
  }
}

class RegisterPageRestorableRouteFuture extends GetRestorableRouteFuture {
  late RestorableRouteFuture<void> _pageRoute;

  RegisterPageRestorableRouteFuture({required String restorationId}) : super(restorationId: restorationId) {
    _pageRoute = RestorableRouteFuture<void>(
      onPresent: (NavigatorState navigator, Object? arguments) {
        if (arguments is String) {
          if (arguments == Constant.restorableRouteFuturePushAndRemoveUntil) {
            return navigator.restorablePushAndRemoveUntil(_pageRouteBuilder, (route) => false, arguments: arguments);
          } else {
            return navigator.restorablePush(_pageRouteBuilder, arguments: arguments);
          }
        } else {
          return navigator.restorablePush(_pageRouteBuilder, arguments: arguments);
        }
      },
    );
  }

  static Route<void>? _getRoute([Object? arguments]) {
    return GetExtended.toWithGetPageRouteReturnValue<void>(
      GetxPageBuilder.buildRestorableGetxPageBuilder(RegisterPageGetPageBuilderAssistant())
    );
  }

  @pragma('vm:entry-point')
  static Route<void> _pageRouteBuilder(BuildContext context, Object? arguments) {
    return _getRoute(arguments)!;
  }

  @override
  bool checkBeforePresent([Object? arguments]) => _getRoute(arguments) != null;

  @override
  void presentIfCheckIsPassed([Object? arguments]) => _pageRoute.present(arguments);

  @override
  void restoreState(Restorator restorator, RestorationBucket? oldBucket, bool initialRestore) {
    restorator.registerForRestoration(_pageRoute, restorationId);
  }

  @override
  void dispose() {
    _pageRoute.dispose();
  }
}

class _StatefulRegisterControllerMediatorWidget extends StatefulWidget {
  final RegisterController registerController;

  const _StatefulRegisterControllerMediatorWidget({
    required this.registerController
  });

  @override
  State<_StatefulRegisterControllerMediatorWidget> createState() => _StatefulRegisterControllerMediatorWidgetState();
}

class _StatefulRegisterControllerMediatorWidgetState extends State<_StatefulRegisterControllerMediatorWidget> {
  late LoginNotifier _loginNotifier;
  final TextEditingController _emailTextEditingController = TextEditingController();
  final TextEditingController _nameTextEditingController = TextEditingController();
  final TextEditingController _passwordTextEditingController = TextEditingController();
  final TextEditingController _passwordConfirmationTextEditingController = TextEditingController();
  final TapGestureRecognizer _termAndConditionsTapGestureRecognizer = TapGestureRecognizer();
  final TapGestureRecognizer _privacyPolicyTapGestureRecognizer = TapGestureRecognizer();
  late final GoogleSignIn _googleSignIn;
  bool _obscurePassword = true;
  bool _obscurePasswordConfirmation = false;

  @override
  void initState() {
    super.initState();
    _loginNotifier = Provider.of<LoginNotifier>(context, listen: false);
    _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    widget.registerController.setRegisterDelegate(
      RegisterDelegate(
        onUnfocusAllWidget: () => FocusScope.of(context).unfocus(),
        onGetEmailRegisterInput: () => _emailTextEditingController.text,
        onGetNameRegisterInput: () => _nameTextEditingController.text,
        onGetPasswordRegisterInput: () => _passwordTextEditingController.text,
        onGetPasswordConfirmationRegisterInput: () => _passwordConfirmationTextEditingController.text,
        onRegisterBack: () => Get.back(),
        onShowRegisterRequestProcessLoadingCallback: () async => DialogHelper.showLoadingDialog(context),
        onShowRegisterRequestProcessFailedCallback: (e) async => DialogHelper.showFailedModalBottomDialogFromErrorProvider(
          context: context,
          errorProvider: Injector.locator<ErrorProvider>(),
          e: e
        ),
        onRegisterRequestProcessSuccessCallback: () async {
          _loginNotifier.loadProfile();
          Map<String, RouteWrapper?> routeMap = MainRouteObserver.routeMap;
          for (var element in routeMap.entries) {
            element.value?.requestLoginChangeValue = 1;
          }
          NavigationHelper.navigationAfterRegisterProcess(context);
        },
        onRegisterWithGoogle: () async {
          GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
          if (googleSignInAccount == null) {
            return null;
          }
          GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
          return googleSignInAuthentication.idToken;
        },
      )
    );
    return Scaffold(
      appBar: ModifiedAppBar(
        titleInterceptor: (context, title) => Row(
          children: [
            Text("Register".tr),
            Expanded(
              child: title ?? Container()
            ),
            DefaultTextStyle(
              style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold),
              softWrap: false,
              overflow: TextOverflow.ellipsis,
              child: GestureDetector(
                onTap: () => Get.back(),
                child: Text("Login".tr),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (OverscrollIndicatorNotification overscroll) {
            overscroll.disallowIndicator();
            return false;
          },
          child: SingleChildScrollView(
            padding: EdgeInsets.all(4.w),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 30.h,
                  child: FittedBox(
                    child: Image.asset(Constant.imageLogin),
                  )
                ),
                SizedBox(height: 3.h),
                RxConsumer<Validator>(
                  rxValue: widget.registerController.emailValidatorRx,
                  onConsumeValue: (context, value) => Field(
                    child: (context, validationResult, validator) => ModifiedTextField(
                      isError: validationResult.isFailed,
                      controller: _emailTextEditingController,
                      decoration: DefaultInputDecoration(
                        label: Text("Email".tr),
                        labelStyle: const TextStyle(color: Colors.black),
                        floatingLabelStyle: const TextStyle(color: Colors.black),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                      onChanged: (value) => validator?.validate(),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    validator: value,
                  ),
                ),
                SizedBox(height: 3.h),
                RxConsumer<Validator>(
                  rxValue: widget.registerController.nameValidatorRx,
                  onConsumeValue: (context, value) => Field(
                    child: (context, validationResult, validator) => ModifiedTextField(
                      isError: validationResult.isFailed,
                      controller: _nameTextEditingController,
                      decoration: DefaultInputDecoration(
                        label: Text("Name".tr),
                        labelStyle: const TextStyle(color: Colors.black),
                        floatingLabelStyle: const TextStyle(color: Colors.black),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                      onChanged: (value) => validator?.validate(),
                      textInputAction: TextInputAction.next,
                    ),
                    validator: value,
                  ),
                ),
                SizedBox(height: 3.h),
                RxConsumer<PasswordCompoundValidator>(
                  rxValue: widget.registerController.passwordCompoundValidatorRx,
                  onConsumeValue: (context, passwordCompoundValidator) => Field(
                    child: (context, validationResult, validator) => ModifiedTextField(
                      isError: validationResult.isFailed,
                      controller: _passwordTextEditingController,
                      decoration: DefaultInputDecoration(
                        label: Text("Password".tr),
                        labelStyle: const TextStyle(color: Colors.black),
                        floatingLabelStyle: const TextStyle(color: Colors.black),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        suffixIcon: PasswordObscurer(
                          obscurePassword: _obscurePassword,
                          onObscurePassword: () => setState(() => _obscurePassword = !_obscurePassword),
                        )
                      ),
                      obscureText: _obscurePassword,
                      onChanged: (value) => passwordCompoundValidator.validate(),
                      textInputAction: TextInputAction.next,
                    ),
                    validator: passwordCompoundValidator.passwordValidator,
                  )
                ),
                SizedBox(height: 3.h),
                RxConsumer<PasswordCompoundValidator>(
                  rxValue: widget.registerController.passwordCompoundValidatorRx,
                  onConsumeValue: (context, passwordCompoundValidator) => Field(
                    child: (context, validationResult, validator) => ModifiedTextField(
                      isError: validationResult.isFailed,
                      controller: _passwordConfirmationTextEditingController,
                      decoration: DefaultInputDecoration(
                        label: Text("Password Confirmation".tr),
                        labelStyle: const TextStyle(color: Colors.black),
                        floatingLabelStyle: const TextStyle(color: Colors.black),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        suffixIcon: PasswordObscurer(
                          obscurePassword: _obscurePasswordConfirmation,
                          onObscurePassword: () => setState(() => _obscurePasswordConfirmation = !_obscurePasswordConfirmation),
                        )
                      ),
                      obscureText: _obscurePasswordConfirmation,
                      onChanged: (value) => passwordCompoundValidator.validate(),
                      textInputAction: TextInputAction.done,
                      onEditingComplete: widget.registerController.register,
                    ),
                    validator: passwordCompoundValidator.passwordConfirmationValidator,
                  )
                ),
                SizedBox(height: 3.h),
                SizedOutlineGradientButton(
                  width: double.infinity,
                  onPressed: widget.registerController.register,
                  text: "Register".tr,
                ),
                SizedBox(height: 3.h),
                Row(
                  children: [
                    const Expanded(
                      child: Divider()
                    ),
                    SizedBox(width: 6.w),
                    Text("or register with".tr, style: TextStyle(
                      color: Theme.of(context).dividerTheme.color
                    )),
                    SizedBox(width: 6.w),
                    const Expanded(
                      child: Divider()
                    ),
                  ],
                ),
                SizedBox(height: 3.h),
                SizedOutlineGradientButton(
                  width: double.infinity,
                  outlineGradientButtonType: OutlineGradientButtonType.outline,
                  onPressed: widget.registerController.registerWithGoogle,
                  text: "Register With Google".tr,
                ),
                SizedBox(height: 2.h),
                Builder(
                  builder: (context) {
                    return Text.rich(
                      "By signing up".trTextSpan(
                        parameter: SignUpRecognizer(
                          termAndConditionsTapGestureRecognizer: _termAndConditionsTapGestureRecognizer,
                          privacyPolicyTapGestureRecognizer: _privacyPolicyTapGestureRecognizer
                        ),
                      ),
                      textAlign: TextAlign.center,
                    );
                  }
                )
              ],
            ),
          ),
        )
      )
    );
  }

  @override
  void dispose() {
    _emailTextEditingController.dispose();
    _nameTextEditingController.dispose();
    _passwordTextEditingController.dispose();
    _passwordConfirmationTextEditingController.dispose();
    _termAndConditionsTapGestureRecognizer.dispose();
    _privacyPolicyTapGestureRecognizer.dispose();
    super.dispose();
  }
}