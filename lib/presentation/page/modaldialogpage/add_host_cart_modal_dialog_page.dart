import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masterbagasi/misc/ext/validation_result_ext.dart';
import 'package:sizer/sizer.dart';

import '../../../controller/modaldialogcontroller/add_host_cart_modal_dialog_controller.dart';
import '../../../domain/usecase/add_host_cart_use_case.dart';
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

class AddHostCartModalDialogPage extends ModalDialogPage<AddHostCartModalDialogController> {
  AddHostCartModalDialogController get addHostCartModalDialogController => modalDialogController.controller;

  AddHostCartModalDialogPage({
    Key? key,
  }) : super(key: key);

  @override
  AddHostCartModalDialogController onCreateModalDialogController() {
    return AddHostCartModalDialogController(
      controllerManager,
      Injector.locator<AddHostCartUseCase>()
    );
  }

  @override
  Widget buildPage(BuildContext context) {
    return _StatefulAddHostCartControllerMediatorWidget(
      addHostCartModalDialogController: addHostCartModalDialogController,
    );
  }
}

class _StatefulAddHostCartControllerMediatorWidget extends StatefulWidget {
  final AddHostCartModalDialogController addHostCartModalDialogController;

  const _StatefulAddHostCartControllerMediatorWidget({
    required this.addHostCartModalDialogController
  });

  @override
  State<_StatefulAddHostCartControllerMediatorWidget> createState() => _StatefulAddHostCartControllerMediatorWidgetState();
}

class _StatefulAddHostCartControllerMediatorWidgetState extends State<_StatefulAddHostCartControllerMediatorWidget> {
  final TextEditingController _hostCartIdTextEditingController = TextEditingController();
  final TextEditingController _hostCartPasswordTextEditingController = TextEditingController();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    widget.addHostCartModalDialogController.setAddHostCartModalDialogDelegate(
      AddHostCartModalDialogDelegate(
        onUnfocusAllWidget: () => FocusScope.of(context).unfocus(),
        onGetHostCartIdInput: () => _hostCartIdTextEditingController.text,
        onGetHostCartPasswordInput: () => _hostCartPasswordTextEditingController.text,
        onAddHostCartBack: () => Get.back(),
        onShowAddHostCartRequestProcessLoadingCallback: () async => DialogHelper.showLoadingDialog(context),
        onShowAddHostCartRequestProcessFailedCallback: (e) async => DialogHelper.showFailedModalBottomDialogFromErrorProvider(
          context: context,
          errorProvider: Injector.locator<ErrorProvider>(),
          e: e
        ),
        onAddHostCartRequestProcessSuccessCallback: () async => Get.back(result: true),
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
                text: "Host Cart".tr,
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
            rxValue: widget.addHostCartModalDialogController.hostCartIdValidatorRx,
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
            rxValue: widget.addHostCartModalDialogController.hostCartPasswordValidatorRx,
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
            onPressed: widget.addHostCartModalDialogController.createHostCart,
            text: "Create Host Cart".tr,
            outlineGradientButtonType: OutlineGradientButtonType.solid,
            outlineGradientButtonVariation: OutlineGradientButtonVariation.variation2,
          ),
        ]
      )
    );
  }
}