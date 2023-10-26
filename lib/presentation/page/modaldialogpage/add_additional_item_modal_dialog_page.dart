import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masterbagasi/misc/ext/string_ext.dart';
import 'package:masterbagasi/misc/ext/validation_result_ext.dart';
import 'package:sizer/sizer.dart';

import '../../../controller/modaldialogcontroller/add_additional_item_modal_dialog_controller.dart';
import '../../../domain/entity/additionalitem/additional_item.dart';
import '../../../domain/usecase/add_additional_item_use_case.dart';
import '../../../domain/usecase/change_additional_item_use_case.dart';
import '../../../misc/dialog_helper.dart';
import '../../../misc/errorprovider/error_provider.dart';
import '../../../misc/injector.dart';
import '../../../misc/inputdecoration/default_input_decoration.dart';
import '../../../misc/validation/validator/validator.dart';
import '../../widget/button/custombutton/sized_outline_gradient_button.dart';
import '../../widget/field.dart';
import '../../widget/modified_text_field.dart';
import '../../widget/rx_consumer.dart';
import 'modal_dialog_page.dart';

class AddAdditionalItemModalDialogPage extends ModalDialogPage<AddAdditionalItemModalDialogController> {
  final String? serializedJsonAdditionalItemModalDialogParameter;

  AddAdditionalItemModalDialogController get addAdditionalItemModalDialogController => modalDialogController.controller;

  AddAdditionalItemModalDialogPage({
    Key? key,
    this.serializedJsonAdditionalItemModalDialogParameter
  }) : super(key: key);

  @override
  AddAdditionalItemModalDialogController onCreateModalDialogController() {
    return AddAdditionalItemModalDialogController(
      controllerManager,
      Injector.locator<AddAdditionalItemUseCase>(),
      Injector.locator<ChangeAdditionalItemUseCase>(),
    );
  }

  @override
  Widget buildPage(BuildContext context) {
    return _StatefulAddAdditionalItemControllerMediatorWidget(
      addAdditionalItemModalDialogController: addAdditionalItemModalDialogController,
      serializedJsonAdditionalItemModalDialogParameter: serializedJsonAdditionalItemModalDialogParameter
    );
  }
}

class _StatefulAddAdditionalItemControllerMediatorWidget extends StatefulWidget {
  final AddAdditionalItemModalDialogController addAdditionalItemModalDialogController;
  final String? serializedJsonAdditionalItemModalDialogParameter;

  const _StatefulAddAdditionalItemControllerMediatorWidget({
    required this.addAdditionalItemModalDialogController,
    required this.serializedJsonAdditionalItemModalDialogParameter
  });

  @override
  State<_StatefulAddAdditionalItemControllerMediatorWidget> createState() => _StatefulAddAdditionalItemControllerMediatorWidgetState();
}

class _StatefulAddAdditionalItemControllerMediatorWidgetState extends State<_StatefulAddAdditionalItemControllerMediatorWidget> {
  final TextEditingController _additionalNameTextEditingController = TextEditingController();
  final TextEditingController _additionalEstimationPriceTextEditingController = TextEditingController();
  final TextEditingController _additionalEstimationWeightTextEditingController = TextEditingController();
  final TextEditingController _additionalQuantityTextEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.serializedJsonAdditionalItemModalDialogParameter.isNotEmptyString) {
      AdditionalItem additionalItem = widget.serializedJsonAdditionalItemModalDialogParameter!.toAddAdditionalItemModalDialogParameter().additionalItem;
      _additionalNameTextEditingController.text = additionalItem.name;
      _additionalEstimationPriceTextEditingController.text = additionalItem.estimationPrice.toString();
      _additionalEstimationWeightTextEditingController.text = additionalItem.estimationWeight.toString();
      _additionalQuantityTextEditingController.text = additionalItem.quantity.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    widget.addAdditionalItemModalDialogController.setAddAdditionalItemModalDialogDelegate(
      AddAdditionalItemModalDialogDelegate(
        onUnfocusAllWidget: () => FocusScope.of(context).unfocus(),
        onGetAdditionalItemNameInput: () => _additionalNameTextEditingController.text,
        onGetAdditionalItemEstimationPriceInput: () => _additionalEstimationPriceTextEditingController.text,
        onGetAdditionalItemEstimationWeightInput: () => _additionalEstimationWeightTextEditingController.text,
        onGetAdditionalItemQuantityInput: () => _additionalQuantityTextEditingController.text,
        onAddAdditionalItemBack: () => Get.back(),
        onShowAdditionalItemRequestProcessLoadingCallback: () async => DialogHelper.showLoadingDialog(context),
        onAddAdditionalItemRequestProcessSuccessCallback: (addAdditionalItemModalDialogResponse, base64StringAddAdditionalItemModalDialogResponse) async {
          Get.back(result: base64StringAddAdditionalItemModalDialogResponse);
        },
        onShowAdditionalItemRequestProcessFailedCallback: (e) async => DialogHelper.showFailedModalBottomDialogFromErrorProvider(
          context: context,
          errorProvider: Injector.locator<ErrorProvider>(),
          e: e
        ),
      )
    );
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            IgnorePointer(
              child: ExcludeFocus(
                child: SizedOutlineGradientButton(
                  onPressed: () {},
                  text: "Add New Item".tr,
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
            Text("Name".tr),
            const SizedBox(height: 10),
            RxConsumer<Validator>(
              rxValue: widget.addAdditionalItemModalDialogController.additionalItemNameValidatorRx,
              onConsumeValue: (context, value) => Field(
                child: (context, validationResult, validator) => ModifiedTextField(
                  isError: validationResult.isFailed,
                  controller: _additionalNameTextEditingController,
                  decoration: DefaultInputDecoration(hintText: "Enter name".tr),
                  onChanged: (value) => validator?.validate(),
                  textInputAction: TextInputAction.next,
                ),
                validator: value,
              ),
            ),
            const SizedBox(height: 20),
            Text("Estimation Price".tr),
            const SizedBox(height: 10),
            RxConsumer<Validator>(
              rxValue: widget.addAdditionalItemModalDialogController.additionalItemEstimationPriceValidatorRx,
              onConsumeValue: (context, value) => Field(
                child: (context, validationResult, validator) => ModifiedTextField(
                  isError: validationResult.isFailed,
                  controller: _additionalEstimationPriceTextEditingController,
                  decoration: DefaultInputDecoration(hintText: "Enter estimation price".tr),
                  onChanged: (value) => validator?.validate(),
                  textInputAction: TextInputAction.next,
                ),
                validator: value,
              ),
            ),
            const SizedBox(height: 20),
            Text("Estimation Weight".tr),
            const SizedBox(height: 10),
            RxConsumer<Validator>(
              rxValue: widget.addAdditionalItemModalDialogController.additionalItemEstimationWeightValidatorRx,
              onConsumeValue: (context, value) => Field(
                child: (context, validationResult, validator) => ModifiedTextField(
                  isError: validationResult.isFailed,
                  controller: _additionalEstimationWeightTextEditingController,
                  decoration: DefaultInputDecoration(hintText: "Enter estimation weight".tr),
                  onChanged: (value) => validator?.validate(),
                  textInputAction: TextInputAction.next,
                ),
                validator: value,
              ),
            ),
            const SizedBox(height: 20),
            Text("Quantity".tr),
            const SizedBox(height: 10),
            RxConsumer<Validator>(
              rxValue: widget.addAdditionalItemModalDialogController.additionalItemQuantityValidatorRx,
              onConsumeValue: (context, value) => Field(
                child: (context, validationResult, validator) => ModifiedTextField(
                  isError: validationResult.isFailed,
                  controller: _additionalQuantityTextEditingController,
                  decoration: DefaultInputDecoration(hintText: "Enter quantity".tr),
                  onChanged: (value) => validator?.validate(),
                  textInputAction: TextInputAction.next,
                ),
                validator: value,
              ),
            ),
            const SizedBox(height: 20),
            SizedOutlineGradientButton(
              onPressed: widget.addAdditionalItemModalDialogController.createAdditionalItem,
              text: "Add".tr,
              outlineGradientButtonType: OutlineGradientButtonType.solid,
              outlineGradientButtonVariation: OutlineGradientButtonVariation.variation2,
            ),
          ]
        )
      ),
    );
  }

  @override
  void dispose() {
    _additionalNameTextEditingController.dispose();
    _additionalEstimationPriceTextEditingController.dispose();
    _additionalEstimationWeightTextEditingController.dispose();
    _additionalQuantityTextEditingController.dispose();
    super.dispose();
  }
}