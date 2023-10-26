import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masterbagasi/misc/ext/validation_result_ext.dart';
import 'package:sizer/sizer.dart';

import '../../../controller/modaldialogcontroller/add_host_cart_modal_dialog_controller.dart';
import '../../../controller/modaldialogcontroller/take_friend_cart_modal_dialog_controller.dart';
import '../../../domain/usecase/add_host_cart_use_case.dart';
import '../../../domain/usecase/take_friend_cart_use_case.dart';
import '../../../misc/dialog_helper.dart';
import '../../../misc/errorprovider/error_provider.dart';
import '../../../misc/injector.dart';
import '../../../misc/inputdecoration/default_input_decoration.dart';
import '../../../misc/validation/validator/validator.dart';
import '../../widget/button/custombutton/sized_outline_gradient_button.dart';
import '../../widget/field.dart';
import '../../widget/modified_text_field.dart';
import '../../widget/password_obscurer.dart';
import '../../widget/rx_consumer.dart';
import 'modal_dialog_page.dart';

class TakeFriendCartModalDialogPage extends ModalDialogPage<TakeFriendCartModalDialogController> {
  TakeFriendCartModalDialogController get takeFriendCartModalDialogController => modalDialogController.controller;

  TakeFriendCartModalDialogPage({
    Key? key,
  }) : super(key: key);

  @override
  TakeFriendCartModalDialogController onCreateModalDialogController() {
    return TakeFriendCartModalDialogController(
      controllerManager,
      Injector.locator<TakeFriendCartUseCase>()
    );
  }

  @override
  Widget buildPage(BuildContext context) {
    return _StatefulTakeFriendCartControllerMediatorWidget(
      takeFriendCartModalDialogController: takeFriendCartModalDialogController,
    );
  }
}

class _StatefulTakeFriendCartControllerMediatorWidget extends StatefulWidget {
  final TakeFriendCartModalDialogController takeFriendCartModalDialogController;

  const _StatefulTakeFriendCartControllerMediatorWidget({
    required this.takeFriendCartModalDialogController
  });

  @override
  State<_StatefulTakeFriendCartControllerMediatorWidget> createState() => _StatefulTakeFriendCartControllerMediatorWidgetState();
}

class _StatefulTakeFriendCartControllerMediatorWidgetState extends State<_StatefulTakeFriendCartControllerMediatorWidget> {
  final TextEditingController _hostCartIdTextEditingController = TextEditingController();
  final TextEditingController _hostCartPasswordTextEditingController = TextEditingController();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    widget.takeFriendCartModalDialogController.setTakeFriendCartModalDialogDelegate(
      TakeFriendCartModalDialogDelegate(
        onUnfocusAllWidget: () => FocusScope.of(context).unfocus(),
        onGetHostCartIdInput: () => _hostCartIdTextEditingController.text,
        onGetHostCartPasswordInput: () => _hostCartPasswordTextEditingController.text,
        onTakeFriendCartBack: () => Get.back(),
        onShowTakeFriendCartRequestProcessLoadingCallback: () async => DialogHelper.showLoadingDialog(context),
        onShowTakeFriendCartRequestProcessFailedCallback: (e) async => DialogHelper.showFailedModalBottomDialogFromErrorProvider(
          context: context,
          errorProvider: Injector.locator<ErrorProvider>(),
          e: e
        ),
        onTakeFriendCartRequestProcessSuccessCallback: () async => Get.back(result: true),
      )
    );
    return Padding(
      padding: EdgeInsets.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          IgnorePointer(
            child: ExcludeFocus(
              child: SizedOutlineGradientButton(
                onPressed: () {},
                text: "Take Cart Friend".tr,
                outlineGradientButtonType: OutlineGradientButtonType.outline,
                outlineGradientButtonVariation: OutlineGradientButtonVariation.variation1,
                customGradientButtonVariation: (outlineGradientButtonType) {
                  return CustomGradientButtonVariation(
                    outlineGradientButtonType: outlineGradientButtonType,
                    textStyle: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold
                    )
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text("Host Cart Id".tr),
          const SizedBox(height: 10),
          RxConsumer<Validator>(
            rxValue: widget.takeFriendCartModalDialogController.hostCartIdValidatorRx,
            onConsumeValue: (context, value) => Field(
              child: (context, validationResult, validator) => ModifiedTextField(
                isError: validationResult.isFailed,
                controller: _hostCartIdTextEditingController,
                decoration: DefaultInputDecoration(hintText: "Enter host cart id".tr),
                onChanged: (value) => validator?.validate(),
                textInputAction: TextInputAction.next,
              ),
              validator: value,
            ),
          ),
          const SizedBox(height: 20),
          Text("Host Cart Password".tr),
          const SizedBox(height: 10),
          RxConsumer<Validator>(
            rxValue: widget.takeFriendCartModalDialogController.hostCartPasswordValidatorRx,
            onConsumeValue: (context, value) => Field(
              child: (context, validationResult, validator) => ModifiedTextField(
                isError: validationResult.isFailed,
                controller: _hostCartPasswordTextEditingController,
                decoration: DefaultInputDecoration(
                  hintText: "Enter host cart password".tr,
                  suffixIcon: PasswordObscurer(
                    obscurePassword: _obscurePassword,
                    onObscurePassword: () => setState(() => _obscurePassword = !_obscurePassword),
                  )
                ),
                obscureText: _obscurePassword,
                onChanged: (value) => validator?.validate(),
                textInputAction: TextInputAction.next,
              ),
              validator: value,
            ),
          ),
          const SizedBox(height: 20),
          SizedOutlineGradientButton(
            onPressed: widget.takeFriendCartModalDialogController.takeFriendCart,
            text: "Join".tr,
            outlineGradientButtonType: OutlineGradientButtonType.solid,
            outlineGradientButtonVariation: OutlineGradientButtonVariation.variation2,
          ),
        ]
      )
    );
  }
}